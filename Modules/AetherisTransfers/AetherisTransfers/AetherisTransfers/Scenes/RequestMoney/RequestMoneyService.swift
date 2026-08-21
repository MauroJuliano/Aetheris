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
