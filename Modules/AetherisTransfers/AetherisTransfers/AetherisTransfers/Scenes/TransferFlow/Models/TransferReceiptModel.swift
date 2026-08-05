import AetherisAuthenticationInterface
import Foundation

struct TransferDraft: Hashable {
    let amount: Decimal
    let formattedAmount: String
    let currency: String
    let beneficiaryName: String
    let beneficiaryIdentifier: String
    let accountName: String
    let accountLastDigits: String
}

struct TransferSubmission: Hashable {
    let draft: TransferDraft
    let authorization: IdentityAuthorization
    let idempotencyKey: String
}

struct TransferRequest: Encodable {
    let amount: Decimal
    let currency: String
    let beneficiaryIdentifier: String
    let authorizationToken: String
}

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

struct TransferReceiptModel: Hashable {
    let amount: String
    let recipientName: String
    let recipientEmail: String
    let accountName: String
    let accountLastDigits: String
    let date: String
    let referenceId: String
}

extension TransferReceiptModel {
    init(response: TransferReceiptResponse) {
        amount = Self.format(amount: response.amount, currency: response.currency)
        recipientName = response.recipientName
        recipientEmail = response.recipientIdentifier
        accountName = response.accountName
        accountLastDigits = response.accountLastDigits
        date = response.completedAt
        referenceId = response.referenceId
    }

    private static func format(amount: Double, currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "\(currency) \(amount)"
    }
}
