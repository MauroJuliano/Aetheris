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

extension TransferReceiptModel {
    init(response: TransferReceiptResponse) {
        amount = Self.format(amount: response.amount, currency: response.currency)
        recipientName = response.recipientName
        recipientEmail = response.recipientIdentifier
        accountName = Self.localizedAccountName(response.accountName)
        accountLastDigits = response.accountLastDigits
        date = Self.format(date: response.completedAt)
        referenceId = response.referenceId
    }

    private static func format(amount: Double, currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = currentLocale
        formatter.currencyCode = currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "\(currency) \(amount)"
    }

    private static func format(date value: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        guard let date = inputFormatter.date(from: value) else { return value }

        let formatter = DateFormatter()
        formatter.locale = currentLocale
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private static func localizedAccountName(_ value: String) -> String {
        value == "Main Account" ? Strings.TransferSuccess.mainAccount : value
    }

    private static var currentLocale: Locale {
        Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
    }
}
