import Foundation

struct MerchantDetailsModel: Codable, Equatable {
    let merchantId: UUID
    let merchantName: String
    let descriptor: String?
    let category: String
    let location: String?
    let paymentMethod: PaymentMethodSummaryModel
}
