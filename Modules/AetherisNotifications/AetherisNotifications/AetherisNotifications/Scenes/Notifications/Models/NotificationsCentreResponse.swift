import Foundation

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
        notifications: [
            .init(title: Strings.Notifications.titleTransferSent, leadingContent: .image("sophie"), date: Date(), hasDivider: true),
            .init(title: Strings.Notifications.titlePaymentReceived, leadingContent: .image("Amelia"), date: Date(), hasDivider: true),
            .init(title: Strings.Notifications.titleSubscriptionRenewed, leadingContent: .icon("bell"), date: Date(), hasDivider: true),
            .init(title: Strings.Notifications.titleRefundProcessed, leadingContent: .icon("wrench.and.screwdriver"), date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, hasDivider: true),
            .init(title: Strings.Notifications.titleSubscriptionExpired, leadingContent: .icon("calendar"), date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!, hasDivider: true),
            .init(title: Strings.Notifications.titleMaintenanceCompleted, leadingContent: .icon("gearshape"), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!, hasDivider: true)
        ]
    )
}
