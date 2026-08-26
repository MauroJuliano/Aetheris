import Foundation
import Testing
@testable import AetherisNotifications

@Suite("NotificationTimeLabelFormatter")
struct NotificationTimeLabelFormatterTests {
    @Test
    func label_formatsTodayYesterdayAndOlderDates() {
        let calendar = Calendar.current
        let now = Date()

        let today = NotificationTimeLabelFormatter.label(
            for: now,
            now: now,
            calendar: calendar
        )

        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: now)!
        let yesterday = NotificationTimeLabelFormatter.label(
            for: yesterdayDate,
            now: now,
            calendar: calendar
        )

        let recentDate = calendar.date(byAdding: .day, value: -3, to: now)!
        let recent = NotificationTimeLabelFormatter.label(
            for: recentDate,
            now: now,
            calendar: calendar
        )

        let olderDate = calendar.date(byAdding: .month, value: -2, to: now)!
        let older = NotificationTimeLabelFormatter.label(
            for: olderDate,
            now: now,
            calendar: calendar
        )

        #expect(today.contains(":"))
        #expect(yesterday == Strings.Notifications.sectionYesterday)
        #expect(recent == "3 days ago")
        #expect(older == "2 months ago")
    }
}
