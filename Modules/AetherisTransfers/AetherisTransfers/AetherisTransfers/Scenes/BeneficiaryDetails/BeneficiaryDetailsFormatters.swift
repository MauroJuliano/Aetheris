import Foundation

extension Locale {
    static let beneficiaryDetails = Locale(identifier: "en_US")
}

extension Date {
    var beneficiaryTransactionDateFormatted: String {
        formatted(
            .dateTime
                .month(.abbreviated)
                .day()
                .year()
                .locale(.beneficiaryDetails)
        )
    }
}
