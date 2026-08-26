import Foundation

struct SubscriptionDetailsModel: Codable, Equatable {
    let merchantId: UUID
    let merchantName: String
    let merchantDescriptor: String?
    let merchantImageName: String?
    let category: String
    let billingFrequency: BillingFrequency
    let lastPaymentDate: Date
    let nextExpectedPaymentDate: Date?
    let expectedAmount: Decimal
    let currencyCode: String
    let paymentMethod: PaymentMethodSummaryModel
    let paymentHistory: [SubscriptionPaymentHistoryModel]
    let isRecurringPaymentDetected: Bool
    let merchantIsBlocked: Bool
}
