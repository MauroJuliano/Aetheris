import Foundation
import Testing
@testable import AetherisTransfers

@Suite("BeneficiaryDetailsFormatters")
struct BeneficiaryDetailsFormattersTests {
    @Test
    func beneficiaryTransactionDateFormatted_respectsEnglishLocale() {
        let date = makeDate(year: 2026, month: 8, day: 18)
        let formatted = date.beneficiaryTransactionDateFormatted(locale: Locale(identifier: "en_US"))

        #expect(formatted.contains("Aug"))
        #expect(formatted.contains("2026"))
    }

    @Test
    func beneficiaryTransactionDateFormatted_respectsBrazilianPortugueseLocale() {
        let date = makeDate(year: 2026, month: 8, day: 18)
        let formatted = date.beneficiaryTransactionDateFormatted(locale: Locale(identifier: "pt_BR"))

        #expect(formatted.lowercased().contains("ago"))
        #expect(formatted.contains("2026"))
    }

    private func makeDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.calendar = Calendar(identifier: .gregorian)
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return components.date ?? Date(timeIntervalSince1970: 0)
    }
}
