import Foundation

struct SubscriptionPaymentHistoryModel: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let amount: Decimal
    let currencyCode: String
    let status: TransactionStatus
}
