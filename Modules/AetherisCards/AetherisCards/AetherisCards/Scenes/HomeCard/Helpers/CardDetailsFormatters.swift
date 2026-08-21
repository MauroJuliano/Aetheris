import Foundation

extension Decimal {
    var currencyFormatted: String {
        formatted(
            .currency(code: "BRL")
                .locale(.cardDetails)
        )
    }
}

extension Date {
    var dueDateFormatted: String {
        formatted(
            .dateTime
                .day(.twoDigits)
                .month(.abbreviated)
                .year()
                .locale(.cardDetails)
        )
        .uppercased()
    }
}

private extension Locale {
    static var cardDetails: Locale {
        Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
    }
}
