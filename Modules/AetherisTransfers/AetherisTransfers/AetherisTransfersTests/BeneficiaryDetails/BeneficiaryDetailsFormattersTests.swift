import Foundation
import Testing
@testable import AetherisTransfers

@Suite("BeneficiaryDetailsFormatters")
struct BeneficiaryDetailsFormattersTests {
    @Test
    func beneficiaryTransactionDateFormatted_usesShortEnglishDate() {
        let date = makeDate(year: 2026, month: 8, day: 18)

        #expect(date.beneficiaryTransactionDateFormatted.contains("Aug"))
        #expect(date.beneficiaryTransactionDateFormatted.contains("2026"))
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
