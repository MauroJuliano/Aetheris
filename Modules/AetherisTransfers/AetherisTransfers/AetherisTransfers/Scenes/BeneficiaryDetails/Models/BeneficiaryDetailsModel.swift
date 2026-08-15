import AetherisTransfersInterface
import Foundation

struct BeneficiaryDetailsModel: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let imageName: String?
    let initials: String
    let kind: BeneficiaryKind
    let isVerified: Bool
    let information: BeneficiaryInformationModel
    let transactionSummary: BeneficiaryTransactionSummaryModel
    let recentTransactions: [BeneficiaryTransactionModel]

    var transferBeneficiary: Beneficiary {
        Beneficiary(
            id: id,
            name: name,
            pixKey: information.accountInformation ?? information.email ?? name,
            image: imageName ?? "",
            hasDivider: true
        )
    }

    var requestContact: RequestContactModel {
        RequestContactModel(
            id: id,
            name: name,
            contactInformation: information.email ?? information.phone ?? information.accountInformation ?? name,
            imageName: imageName
        )
    }
}

enum BeneficiaryKind: String, Codable, Equatable {
    case contact
    case business
    case bankAccount

    var title: String {
        switch self {
        case .contact:
            return Strings.BeneficiaryDetails.contact
        case .business:
            return Strings.BeneficiaryDetails.business
        case .bankAccount:
            return Strings.BeneficiaryDetails.bankAccount
        }
    }

    var icon: String {
        switch self {
        case .contact:
            return "person"
        case .business:
            return "building.2"
        case .bankAccount:
            return "building.columns"
        }
    }
}

struct BeneficiaryInformationModel: Codable, Equatable {
    let email: String?
    let phone: String?
    let location: String?
    let accountInformation: String?
}

struct BeneficiaryTransactionSummaryModel: Codable, Equatable {
    let sentAmount: Decimal
    let receivedAmount: Decimal
    let currencyCode: String
    let sentTransactionsCount: Int
    let receivedTransactionsCount: Int

    var netAmount: Decimal {
        receivedAmount - sentAmount
    }

    var totalTransactionsCount: Int {
        sentTransactionsCount + receivedTransactionsCount
    }
}

struct BeneficiaryTransactionModel: Identifiable, Codable, Equatable {
    let id: UUID
    let kind: BeneficiaryTransactionKind
    let title: String
    let description: String?
    let amount: Decimal
    let currencyCode: String
    let date: Date
    let status: BeneficiaryTransactionStatus

    var isIncoming: Bool {
        kind == .received
    }

    var formattedAmount: String {
        let formattedValue = abs(amount).formatted(
            .currency(code: currencyCode)
                .locale(.beneficiaryDetails)
        )

        return isIncoming ? "+\(formattedValue)" : "-\(formattedValue)"
    }
}

enum BeneficiaryTransactionKind: String, Codable, Equatable {
    case sent
    case received

    var icon: String {
        switch self {
        case .sent:
            return "arrow.up.right"
        case .received:
            return "arrow.down"
        }
    }
}

enum BeneficiaryTransactionStatus: String, Codable, Equatable {
    case pending
    case completed
    case failed

    var title: String {
        switch self {
        case .pending:
            return Strings.BeneficiaryDetails.pending
        case .completed:
            return Strings.BeneficiaryDetails.completed
        case .failed:
            return Strings.BeneficiaryDetails.failed
        }
    }
}
