import Foundation

struct TransferReceiptModel: Hashable {
    let amount: String
    let recipientName: String
    let recipientEmail: String
    let accountName: String
    let accountLastDigits: String
    let date: String
    let referenceId: String
}
