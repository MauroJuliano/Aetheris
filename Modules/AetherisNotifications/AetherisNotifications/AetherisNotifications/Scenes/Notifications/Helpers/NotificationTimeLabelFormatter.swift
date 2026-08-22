import Foundation

enum NotificationTimeLabelFormatter {
    static func label(
        for date: Date,
        now: Date = Date(),
        calendar: Calendar = .current
    ) -> String {
        let formatter = DateFormatter()

        if calendar.isDateInToday(date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        }

        if calendar.isDateInYesterday(date) {
            return Strings.Notifications.sectionYesterday
        }

        let days = calendar.dateComponents([.day], from: date, to: now).day ?? 0

        if days < 30 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        }

        let months = max(1, days / 30)
        return months == 1 ? "1 month ago" : "\(months) months ago"
    }
}
