import Core
import Foundation
import Testing
@testable import Payments

@Suite("NotificationsCentreService")
struct NotificationsCentreServiceTests {
    @Test
    func loadNotifications_returnsMockNotifications() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = NotificationsCentreService(coreService: coreService)

        let notifications = try await sut.loadNotifications()

        #expect(notifications.count == 5)
        #expect(notifications.map(\.title) == [
            Strings.Notifications.titleTransferSent,
            Strings.Notifications.titlePaymentReceived,
            Strings.Notifications.titleSubscriptionRenewed,
            Strings.Notifications.titleRefundProcessed,
            Strings.Notifications.titleSubscriptionExpired
        ])

        let images = notifications.compactMap { notification -> String? in
            if case let .image(value) = notification.leadingContent {
                return value
            }
            return nil
        }

        let icons = notifications.compactMap { notification -> String? in
            if case let .icon(value) = notification.leadingContent {
                return value
            }
            return nil
        }

        #expect(images == ["melissa", "ed"])
        #expect(icons == ["bell", "wrench.and.screwdriver", "calendar"])
        #expect(notifications[0].section == Strings.Notifications.sectionToday)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/notifications", method: .get)
        ])
    }

    @Test
    func loadNotifications_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = NotificationsCentreService(coreService: coreService)

        do {
            _ = try await sut.loadNotifications()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
