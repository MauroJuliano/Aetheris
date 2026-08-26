import Foundation

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
