import Foundation

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
