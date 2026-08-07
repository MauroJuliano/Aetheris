import Foundation

extension Locale {
    static let transactionDetails = Locale(identifier: "en_US")
}

extension Date {
    var transactionDateFormatted: String {
        formatted(
            .dateTime
                .month(.wide)
                .day()
                .year()
                .hour()
                .minute()
                .locale(.transactionDetails)
        )
    }

    var shortTransactionDateFormatted: String {
        formatted(
            .dateTime
                .month(.abbreviated)
                .day()
                .year()
                .locale(.transactionDetails)
        )
    }
}

extension Decimal {
    func absoluteCurrencyFormatted(code: String) -> String {
        abs(self).formatted(.currency(code: code).locale(.transactionDetails))
    }
}
