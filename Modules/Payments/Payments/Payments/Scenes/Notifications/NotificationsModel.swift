import SwiftUI

public enum NotificationLeadingContent: Codable, Hashable {
    case image(String)
    case icon(String)

    private enum CodingKeys: String, CodingKey {
        case kind
        case value
    }

    private enum Kind: String, Codable {
        case image
        case icon
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(Kind.self, forKey: .kind)
        let value = try container.decode(String.self, forKey: .value)
        switch kind {
        case .image:
            self = .image(value)
        case .icon:
            self = .icon(value)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .image(value):
            try container.encode(Kind.image, forKey: .kind)
            try container.encode(value, forKey: .value)
        case let .icon(value):
            try container.encode(Kind.icon, forKey: .kind)
            try container.encode(value, forKey: .value)
        }
    }
}

public struct Notifications: Identifiable, Codable, Equatable, Hashable {
    public let id: UUID
    let title: String
    let leadingContent: NotificationLeadingContent
    let date: Date
    let hasDivider: Bool
    
    public init(id: UUID = UUID(),
                title: String,
                leadingContent: NotificationLeadingContent,
                date: Date,
                hasDivider: Bool) {
        self.id = id
        self.title = title
        self.leadingContent = leadingContent
        self.date = date
        self.hasDivider = hasDivider
    }
    
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

public struct NotificationsCentreResponse: Codable, Hashable, Equatable {
    public let unreadCount: Int
    public let notifications: [Notifications]

    public init(
        unreadCount: Int,
        notifications: [Notifications]
    ) {
        self.unreadCount = unreadCount
        self.notifications = notifications
    }
}

public extension NotificationsCentreResponse {
    static let mock = NotificationsCentreResponse(
        unreadCount: 3,
        notifications: Notifications.mock
    )
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
