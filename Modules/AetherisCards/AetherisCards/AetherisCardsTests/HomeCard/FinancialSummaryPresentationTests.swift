import Foundation
import Testing
@testable import AetherisCards

@Suite("FinancialSummaryPresentation")
struct FinancialSummaryPresentationTests {
    @Test
    func section_groupsDatesInExpectedBuckets() {
        let calendar = Calendar.current
        let now = Date()

        #expect(
            FinancialSummaryPresentation.section(
                for: now,
                now: now,
                calendar: calendar
            ) == Strings.Notifications.sectionToday
        )

        #expect(
            FinancialSummaryPresentation.section(
                for: calendar.date(byAdding: .day, value: -1, to: now)!,
                now: now,
                calendar: calendar
            ) == Strings.Notifications.sectionYesterday
        )

        #expect(
            FinancialSummaryPresentation.section(
                for: calendar.date(byAdding: .day, value: -4, to: now)!,
                now: now,
                calendar: calendar
            ) == Strings.Notifications.sectionLastWeek
        )

        #expect(
            FinancialSummaryPresentation.section(
                for: calendar.date(byAdding: .day, value: -18, to: now)!,
                now: now,
                calendar: calendar
            ) == Strings.Notifications.sectionLastMonth
        )

        #expect(
            FinancialSummaryPresentation.section(
                for: calendar.date(byAdding: .month, value: -2, to: now)!,
                now: now,
                calendar: calendar
            ) == Strings.Notifications.sectionOthers
        )
    }

    @Test
    func dateLabel_formatsRelativeTime() {
        let calendar = Calendar.current
        let now = Date()

        let label = FinancialSummaryPresentation.dateLabel(
            for: calendar.date(byAdding: .day, value: -2, to: now)!,
            now: now,
            calendar: calendar
        )

        #expect(label == "2 days ago")
    }
}
