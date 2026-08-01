import Core
import Foundation

protocol NotificationsCentreServicing {
    func loadNotifications() async throws -> NotificationsCentreResponse
}

final class NotificationsCentreService: NotificationsCentreServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadNotifications() async throws -> NotificationsCentreResponse {
        try await coreService.execute(NotificationsEndpoint.notifications)
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
            return Self.encodeOrEmpty(NotificationsCentreResponse.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
