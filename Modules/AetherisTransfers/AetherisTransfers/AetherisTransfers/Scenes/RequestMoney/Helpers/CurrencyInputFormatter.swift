import Foundation

enum CurrencyInputFormatter {
    private static let locale = Locale(identifier: "pt_BR")

    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = locale
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    static func format(_ input: String) -> String {
        let digits = input.filter(\.isNumber)

        guard let value = Decimal(string: digits) else {
            return ""
        }

        return format(value / 100)
    }

    static func format(_ value: Decimal) -> String {
        currencyFormatter.string(from: NSDecimalNumber(decimal: value)) ?? ""
    }

    static func decimal(from formattedValue: String) -> Decimal {
        let digits = formattedValue.filter(\.isNumber)

        guard let value = Decimal(string: digits) else {
            return 0
        }

        return value / 100
    }
}

extension Decimal {
    var requestCurrencyFormatted: String {
        CurrencyInputFormatter.format(self)
    }
}
