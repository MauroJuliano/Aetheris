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
            title: "Funds successfully transferred to Melissa",
            leadingContent: .image("melissa"),
            date: Date(),
            hasDivider: true
        ),

        .init(
            title: "Payment received from Ed",
            leadingContent: .image("ed"),
            date: Date(),
            hasDivider: true
        ),

        .init(
            title: "Subscription renewed for Man's best Friend",
            leadingContent: .icon("bell"),
            date: Date(),
            hasDivider: true
        ),

        .init(
            title: "Refund processed successfully",
            leadingContent: .icon("wrench.and.screwdriver"),
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            hasDivider: true
        ),

        .init(
            title: "Your subscription has expired",
            leadingContent: .icon("calendar"),
            date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
            hasDivider: true
        ),

        .init(
            title: "System maintenance completed",
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
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now),
                  date >= weekAgo {
            return "Last Week"
        } else if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now),
                  date >= monthAgo {
            return "Last Month"
        } else {
            return "Others"
        }
    }
}
