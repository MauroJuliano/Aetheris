import Core
import Foundation

protocol NotificationsCentreServicing {
    func loadNotifications() async throws -> [Notifications]
}

final class NotificationsCentreService: NotificationsCentreServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadNotifications() async throws -> [Notifications] {
        let payloads: [NotificationsPayload] = try await coreService.execute(NotificationsEndpoint.notifications)
        return payloads.compactMap(\.model)
    }
}

private enum NotificationsEndpoint {
    case notifications
}

extension NotificationsEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/notifications"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .notifications:
            return Self.encodeOrEmpty(NotificationsPayload.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct NotificationsPayload: Codable {
    let title: String
    let leadingContent: LeadingContentPayload
    let date: TimeInterval
    let hasDivider: Bool

    static let mock: [NotificationsPayload] = [
        .init(title: Strings.Notifications.titleTransferSent,
              leadingContent: .image("melissa"),
              date: Date().timeIntervalSince1970,
              hasDivider: true),
        .init(title: Strings.Notifications.titlePaymentReceived,
              leadingContent: .image("ed"),
              date: Date().timeIntervalSince1970,
              hasDivider: true),
        .init(title: Strings.Notifications.titleSubscriptionRenewed,
              leadingContent: .icon("bell"),
              date: Date().timeIntervalSince1970,
              hasDivider: true),
        .init(title: Strings.Notifications.titleRefundProcessed,
              leadingContent: .icon("wrench.and.screwdriver"),
              date: Calendar.current.date(byAdding: .day, value: -5, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970,
              hasDivider: true),
        .init(title: Strings.Notifications.titleSubscriptionExpired,
              leadingContent: .icon("calendar"),
              date: Calendar.current.date(byAdding: .day, value: -20, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970,
              hasDivider: true)
    ]

    var model: Notifications? {
        Notifications(
            title: title,
            leadingContent: leadingContent.model,
            date: Date(timeIntervalSince1970: date),
            hasDivider: hasDivider
        )
    }
}

private struct LeadingContentPayload: Codable {
    let kind: String
    let value: String

    static func image(_ value: String) -> LeadingContentPayload {
        .init(kind: "image", value: value)
    }

    static func icon(_ value: String) -> LeadingContentPayload {
        .init(kind: "icon", value: value)
    }

    var model: NotificationLeadingContent {
        switch kind {
        case "image":
            return .image(value)
        default:
            return .icon(value)
        }
    }
}
