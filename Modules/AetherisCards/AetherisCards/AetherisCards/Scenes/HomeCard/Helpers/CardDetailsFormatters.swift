import Foundation

extension Decimal {
    var currencyFormatted: String {
        formatted(
            .currency(code: "BRL")
                .locale(Locale(identifier: "pt_BR"))
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
                .locale(Locale(identifier: "pt_BR"))
        )
        .uppercased()
    }
}
