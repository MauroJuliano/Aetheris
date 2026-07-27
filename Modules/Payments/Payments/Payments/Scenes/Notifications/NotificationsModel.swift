import SwiftUI

public enum NotificationLeadingContent {
    case image(String)
    case icon(String)
}

public struct Notifications: Identifiable {
    public let id = UUID()
    let title: String
    let leadingContent: NotificationLeadingContent
    let date: Date
    let hasDivider: Bool
    
    // For previews & testing
    public static let mock: [Notifications] = [

        .init(
            title: Strings.Notifications.titleTransferSent,
            leadingContent: .image("melissa"),
            date: Date(),
            hasDivider: true
        ),

        .init(
            title: Strings.Notifications.titlePaymentReceived,
            leadingContent: .image("ed"),
            date: Date(),
            hasDivider: true
        ),

        .init(
            title: Strings.Notifications.titleSubscriptionRenewed,
            leadingContent: .icon("bell"),
            date: Date(),
            hasDivider: true
        ),

        .init(
            title: Strings.Notifications.titleRefundProcessed,
            leadingContent: .icon("wrench.and.screwdriver"),
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            hasDivider: true
        ),

        .init(
            title: Strings.Notifications.titleSubscriptionExpired,
            leadingContent: .icon("calendar"),
            date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
            hasDivider: true
        ),

        .init(
            title: Strings.Notifications.titleMaintenanceCompleted,
            leadingContent: .icon("gearshape"),
            date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!,
            hasDivider: true
        )
    ]
}

public extension Notifications {
    var section: String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return Strings.Notifications.sectionToday
        } else if calendar.isDateInYesterday(date) {
            return Strings.Notifications.sectionYesterday
        } else if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now),
                  date >= weekAgo {
            return Strings.Notifications.sectionLastWeek
        } else if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now),
                  date >= monthAgo {
            return Strings.Notifications.sectionLastMonth
        } else {
            return Strings.Notifications.sectionOthers
        }
    }
}
