import Foundation

extension Decimal {
    var invoiceCurrencyFormatted: String {
        let absoluteValue = self < 0 ? -self : self
        let formattedValue = absoluteValue.currencyFormatted

        if self < 0 {
            return "- \(formattedValue)"
        }

        return formattedValue
    }
}

extension Date {
    var invoiceDateFormatted: String {
        formatted(
            .dateTime
                .day(.twoDigits)
                .month(.abbreviated)
                .year()
                .locale(Locale(identifier: "pt_BR"))
        )
        .uppercased()
        .replacingOccurrences(of: ".", with: "")
    }
}
