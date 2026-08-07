import AetherisTransfersInterface
import Core
import Foundation

protocol BeneficiaryDetailsServicing {
    func fetchBeneficiaryDetails(beneficiaryId: UUID) async throws -> BeneficiaryDetailsModel
    func removeBeneficiary(beneficiaryId: UUID) async throws
}

final class BeneficiaryDetailsService: BeneficiaryDetailsServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func fetchBeneficiaryDetails(beneficiaryId: UUID) async throws -> BeneficiaryDetailsModel {
        try await coreService.execute(BeneficiaryDetailsEndpoint.details(beneficiaryId: beneficiaryId))
    }

    func removeBeneficiary(beneficiaryId: UUID) async throws {
        let _: EmptyResponse = try await coreService.execute(
            BeneficiaryDetailsEndpoint.remove(beneficiaryId: beneficiaryId)
        )
    }
}

private enum BeneficiaryDetailsEndpoint {
    case details(beneficiaryId: UUID)
    case remove(beneficiaryId: UUID)
}

extension BeneficiaryDetailsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .details(let beneficiaryId):
            return "/payments/beneficiaries/\(beneficiaryId.uuidString)"
        case .remove(let beneficiaryId):
            return "/payments/beneficiaries/\(beneficiaryId.uuidString)/remove"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .details:
            return .get
        case .remove:
            return .post
        }
    }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .details(let beneficiaryId):
            return Self.encodeOrEmpty(BeneficiaryDetailsMockStore.beneficiary(for: beneficiaryId))
        case .remove:
            return Self.encodeOrEmpty(EmptyResponse())
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

enum BeneficiaryDetailsMockStore {
    static func beneficiary(for beneficiaryId: UUID) -> BeneficiaryDetailsModel {
        let beneficiary = BeneficiaryFixtures.defaults.first { $0.id == beneficiaryId }

        switch beneficiary?.name {
        case "Melissa":
            return model(
                id: beneficiaryId,
                name: "Melissa",
                imageName: "melissa",
                initials: "M",
                kind: .contact,
                email: "contact@melissamccarthy.com",
                phone: "+1 (310) 555-0172",
                location: "Los Angeles, United States",
                account: beneficiary?.pixKey
            )
        case "Adele":
            return model(
                id: beneficiaryId,
                name: "Adele",
                imageName: "Adele",
                initials: "A",
                kind: .contact,
                email: "adele@email.com",
                phone: "+44 20 5555 0101",
                location: "London, United Kingdom",
                account: beneficiary?.pixKey,
                sentAmount: 420,
                receivedAmount: 180
            )
        case "Troy Bolton":
            return model(
                id: beneficiaryId,
                name: "Troy Bolton",
                imageName: "Troy",
                initials: "TB",
                kind: .contact,
                email: "troy@email.com",
                phone: "+1 (505) 555-0144",
                location: "Albuquerque, United States",
                account: beneficiary?.pixKey,
                sentAmount: 310,
                receivedAmount: 0
            )
        default:
            return model(
                id: beneficiaryId,
                name: beneficiary?.name ?? "Ed Sheeran",
                imageName: beneficiary?.image ?? "ed",
                initials: "ES",
                kind: .contact,
                email: "ed.sheeran@email.com",
                phone: "+44 20 5555 0198",
                location: "London, United Kingdom",
                account: beneficiary?.pixKey ?? "afirelove"
            )
        }
    }
}

private extension BeneficiaryDetailsMockStore {
    static func model(
        id: UUID,
        name: String,
        imageName: String?,
        initials: String,
        kind: BeneficiaryKind,
        email: String?,
        phone: String?,
        location: String?,
        account: String?,
        sentAmount: Decimal = 850,
        receivedAmount: Decimal = 125
    ) -> BeneficiaryDetailsModel {
        BeneficiaryDetailsModel(
            id: id,
            name: name,
            imageName: imageName,
            initials: initials,
            kind: kind,
            isVerified: true,
            information: BeneficiaryInformationModel(
                email: email,
                phone: phone,
                location: location,
                accountInformation: account
            ),
            transactionSummary: BeneficiaryTransactionSummaryModel(
                sentAmount: sentAmount,
                receivedAmount: receivedAmount,
                currencyCode: "USD",
                sentTransactionsCount: 3,
                receivedTransactionsCount: receivedAmount > 0 ? 2 : 0
            ),
            recentTransactions: transactions(for: name)
        )
    }

    static func transactions(for name: String) -> [BeneficiaryTransactionModel] {
        [
            BeneficiaryTransactionModel(
                id: UUID(uuidString: "70000000-0000-0000-0000-000000000001")!,
                kind: .received,
                title: Strings.BeneficiaryDetails.paymentReceived,
                description: "Thanks for the collaboration",
                amount: 75,
                currencyCode: "USD",
                date: Date(),
                status: .completed
            ),
            BeneficiaryTransactionModel(
                id: UUID(uuidString: "70000000-0000-0000-0000-000000000002")!,
                kind: .sent,
                title: Strings.BeneficiaryDetails.transferSent,
                description: "Dinner with \(name)",
                amount: 50,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                status: .completed
            ),
            BeneficiaryTransactionModel(
                id: UUID(uuidString: "70000000-0000-0000-0000-000000000003")!,
                kind: .sent,
                title: Strings.BeneficiaryDetails.transferSent,
                description: "Concert ticket",
                amount: 200,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                status: .completed
            )
        ]
    }
}
