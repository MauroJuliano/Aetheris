import Foundation

struct InvoicePaymentDetailsModel: Codable, Equatable {
    let invoiceId: UUID
    let cardId: UUID
    let cardName: String
    let billingPeriod: String
    let paidAmount: Decimal
    let currencyCode: String
    let paymentMethod: PaymentMethodSummaryModel
    let confirmationCode: String
}
