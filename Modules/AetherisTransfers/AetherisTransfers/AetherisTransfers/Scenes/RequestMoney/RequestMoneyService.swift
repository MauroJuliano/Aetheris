import Core
import Foundation

protocol RequestMoneyServicing {
    func loadDashboard() async throws -> RequestMoneyDashboard
    func createRequest(contactId: UUID, amount: Decimal, reason: String?) async throws -> MoneyRequestModel
    func createSharedRequest(amount: Decimal, reason: String?) async throws -> MoneyRequestModel
}

struct RequestMoneyDashboard: Codable, Equatable {
    let requesterName: String
    let recentContacts: [RequestContactModel]
    let amountPresets: [RequestMoneyAmountPresetModel]
    let defaultReason: String?
}

final class RequestMoneyService: RequestMoneyServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadDashboard() async throws -> RequestMoneyDashboard {
        try await coreService.execute(RequestMoneyEndpoint.dashboard)
    }

    func createRequest(
        contactId: UUID,
        amount: Decimal,
        reason: String?
    ) async throws -> MoneyRequestModel {
        let request = RequestMoneyCreateRequest(
            contactId: contactId,
            amount: amount,
            reason: reason
        )

        return try await coreService.execute(
            RequestMoneyEndpoint.createRequest(request)
        )
    }

    func createSharedRequest(
        amount: Decimal,
        reason: String?
    ) async throws -> MoneyRequestModel {
        let request = SharedMoneyCreateRequest(
            amount: amount,
            reason: reason
        )

        return try await coreService.execute(
            RequestMoneyEndpoint.createSharedRequest(request)
        )
    }
}

private struct RequestMoneyCreateRequest: Codable {
    let contactId: UUID
    let amount: Decimal
    let reason: String?
}

private struct SharedMoneyCreateRequest: Codable {
    let amount: Decimal
    let reason: String?
}

private enum RequestMoneyEndpoint {
    case dashboard
    case createRequest(RequestMoneyCreateRequest)
    case createSharedRequest(SharedMoneyCreateRequest)
}

extension RequestMoneyEndpoint: Endpoint {
    var path: String {
        switch self {
        case .dashboard:
            return "/payments/request-money/dashboard"
        case .createRequest:
            return "/payments/money-requests"
        case .createSharedRequest:
            return "/payments/money-requests/share"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dashboard:
            return .get
        case .createRequest, .createSharedRequest:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .dashboard:
            return nil
        case .createRequest(let request):
            return request
        case .createSharedRequest(let request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .dashboard:
            return Self.encodeOrEmpty(RequestMoneyDashboard.mock)
        case .createRequest(let request):
            return Self.encodeOrEmpty(RequestMoneyMock.moneyRequest(for: request))
        case .createSharedRequest(let request):
            return Self.encodeOrEmpty(RequestMoneyMock.sharedRequest(for: request))
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private enum RequestMoneyMock {
    static let contacts: [RequestContactModel] = BeneficiaryFixtures.defaults.map {
        RequestContactModel(
            id: $0.id,
            name: $0.name,
            contactInformation: $0.pixKey,
            imageName: $0.image
        )
    }

    static let amountPresets: [RequestMoneyAmountPresetModel] = [
        RequestMoneyAmountPresetModel(id: "preset_50", value: 50, title: "R$ 50"),
        RequestMoneyAmountPresetModel(id: "preset_100", value: 100, title: "R$ 100"),
        RequestMoneyAmountPresetModel(id: "preset_150", value: 150, title: "R$ 150"),
        RequestMoneyAmountPresetModel(id: "preset_200", value: 200, title: "R$ 200"),
        RequestMoneyAmountPresetModel(id: "preset_300", value: 300, title: "R$ 300")
    ]

    static func moneyRequest(for request: RequestMoneyCreateRequest) -> MoneyRequestModel {
        MoneyRequestModel(
            id: UUID(),
            contact: contacts.first { $0.id == request.contactId },
            amount: request.amount,
            reason: request.reason,
            paymentLink: nil,
            createdAt: Date(),
            status: .pending
        )
    }

    static func sharedRequest(for request: SharedMoneyCreateRequest) -> MoneyRequestModel {
        MoneyRequestModel(
            id: UUID(),
            contact: nil,
            amount: request.amount,
            reason: request.reason,
            paymentLink: URL(string: "https://aetheris.app/request/mock"),
            createdAt: Date(),
            status: .pending
        )
    }
}

private extension RequestMoneyDashboard {
    static let mock = RequestMoneyDashboard(
        requesterName: "Blake Brown",
        recentContacts: RequestMoneyMock.contacts,
        amountPresets: RequestMoneyMock.amountPresets,
        defaultReason: nil
    )
}
