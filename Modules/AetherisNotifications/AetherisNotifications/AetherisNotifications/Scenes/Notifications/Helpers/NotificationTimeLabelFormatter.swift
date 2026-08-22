import Foundation

enum NotificationTimeLabelFormatter {
    static func label(
        for date: Date,
        now: Date = Date(),
        calendar: Calendar = .current
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US")

        if calendar.isDateInToday(date) {
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }

        if calendar.isDateInYesterday(date) {
            return Strings.Notifications.sectionYesterday
        }

        let days = calendar.dateComponents([.day], from: date, to: now).day ?? 0

        if days < 30 {
            return days == 1 ? Strings.Notifications.oneDayAgo : Strings.Notifications.daysAgo(days)
        }

        let months = max(1, days / 30)
        return months == 1 ? Strings.Notifications.oneMonthAgo : Strings.Notifications.monthsAgo(months)
    }
}
