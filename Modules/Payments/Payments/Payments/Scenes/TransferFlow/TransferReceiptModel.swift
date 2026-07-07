import Foundation

struct TransferReceiptModel {
    let amount: String
    let recipientName: String
    let recipientEmail: String
    let accountName: String
    let accountLastDigits: String
    let date: String
    let referenceId: String

    static let mock = TransferReceiptModel(
        amount: "$250.00",
        recipientName: "Melissa Johnson",
        recipientEmail: "melissa.j@email.com",
        accountName: "Main Account",
        accountLastDigits: "1234",
        date: "June 22, 2024 at 4:45 PM",
        referenceId: "TRX20240622-445PM"
    )
}
