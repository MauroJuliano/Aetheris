import Foundation

struct TransferReceiptResponse: Codable, Hashable {
    let transactionId: String
    let referenceId: String
    let status: String
    let amount: Double
    let currency: String
    let recipientName: String
    let recipientIdentifier: String
    let accountName: String
    let accountLastDigits: String
    let completedAt: String
}
