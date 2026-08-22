import Foundation

extension Locale {
    static var beneficiaryDetails: Locale {
        Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
    }
}

extension Date {
    var beneficiaryTransactionDateFormatted: String {
        beneficiaryTransactionDateFormatted(locale: .beneficiaryDetails)
    }

    func beneficiaryTransactionDateFormatted(locale: Locale) -> String {
        formatted(
            .dateTime
                .month(.abbreviated)
                .day()
                .year()
                .locale(locale)
        )
    }
}
