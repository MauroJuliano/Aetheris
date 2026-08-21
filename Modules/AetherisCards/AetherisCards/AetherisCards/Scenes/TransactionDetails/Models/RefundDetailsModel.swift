import Foundation

struct RefundDetailsModel: Codable, Equatable {
    let originalTransactionId: UUID
    let originalMerchantName: String
    let originalPurchaseDate: Date
    let refundReason: String?
    let expectedAvailabilityDate: Date?
}
