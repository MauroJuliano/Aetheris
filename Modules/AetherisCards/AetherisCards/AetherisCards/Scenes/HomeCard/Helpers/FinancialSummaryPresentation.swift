import Foundation

enum FinancialSummaryPresentation {
    static func section(
        for date: Date,
        now: Date = Date(),
        calendar: Calendar = .current
    ) -> String {
        if calendar.isDateInToday(date) {
            return Strings.Notifications.sectionToday
        }

        if calendar.isDateInYesterday(date) {
            return Strings.Notifications.sectionYesterday
        }

        if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now),
           date >= weekAgo {
            return Strings.Notifications.sectionLastWeek
        }

        if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now),
           date >= monthAgo {
            return Strings.Notifications.sectionLastMonth
        }

        return Strings.Notifications.sectionOthers
    }

    static func dateLabel(
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
            return Strings.FinancialSummary.daysAgo(days)
        }

        return Strings.FinancialSummary.monthAgo(max(1, days / 30))
    }
}
