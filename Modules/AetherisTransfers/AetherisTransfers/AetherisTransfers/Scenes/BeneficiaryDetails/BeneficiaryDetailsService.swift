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
        case "Sophie Keller":
            return model(
                id: beneficiaryId,
                name: "Sophie Keller",
                imageName: "sophie",
                initials: "SK",
                kind: .contact,
                email: "sophie.keller@aetheris.app",
                phone: "+49 211 555 0101",
                location: "Düsseldorf, Germany",
                account: beneficiary?.pixKey
            )
        case "Amelia Thompson":
            return model(
                id: beneficiaryId,
                name: "Amelia Thompson",
                imageName: "Amelia",
                initials: "AT",
                kind: .contact,
                email: "amelia.thompson@aetheris.app",
                phone: "+1 (416) 555-0102",
                location: "Toronto, Canada",
                account: beneficiary?.pixKey,
                sentAmount: 420,
                receivedAmount: 180
            )
        case "Léa Tremblay":
            return model(
                id: beneficiaryId,
                name: "Léa Tremblay",
                imageName: "lea",
                initials: "LT",
                kind: .contact,
                email: "lea.tremblay@aetheris.app",
                phone: "+1 (514) 555-0103",
                location: "Montréal, Canada",
                account: beneficiary?.pixKey,
                sentAmount: 310,
                receivedAmount: 0
            )
        case "Maya Patel":
            return model(
                id: beneficiaryId,
                name: "Maya Patel",
                imageName: "maya",
                initials: "MP",
                kind: .contact,
                email: "maya.patel@aetheris.app",
                phone: "+1 (604) 555-0104",
                location: "Vancouver, Canada",
                account: beneficiary?.pixKey,
                sentAmount: 510,
                receivedAmount: 95
            )
        case "Hannah Schneider":
            return model(
                id: beneficiaryId,
                name: "Hannah Schneider",
                imageName: "hanna",
                initials: "HS",
                kind: .contact,
                email: "hannah.schneider@aetheris.app",
                phone: "+49 30 555 0105",
                location: "Berlin, Germany",
                account: beneficiary?.pixKey,
                sentAmount: 220,
                receivedAmount: 60
            )
        case "Blake Lehmann":
            return model(
                id: beneficiaryId,
                name: "Blake Lehmann",
                imageName: "blake",
                initials: "BL",
                kind: .contact,
                email: "blake.lehmann@aetheris.app",
                phone: "+49 221 555 0106",
                location: "Cologne, Germany",
                account: beneficiary?.pixKey,
                sentAmount: 980,
                receivedAmount: 240
            )
        default:
            return model(
                id: beneficiaryId,
                name: beneficiary?.name ?? "Blake Lehmann",
                imageName: beneficiary?.image ?? "blake",
                initials: "BL",
                kind: .contact,
                email: "blake.lehmann@aetheris.app",
                phone: "+49 221 555 0106",
                location: "Cologne, Germany",
                account: beneficiary?.pixKey ?? "blake.lehmann@aetheris.app"
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
