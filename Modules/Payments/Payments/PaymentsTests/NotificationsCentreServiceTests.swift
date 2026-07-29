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

        let response = try await sut.loadNotifications()

        #expect(response.unreadCount == 3)
        #expect(response.notifications.count == 6)
        #expect(response.notifications.map(\.title) == [
            Strings.Notifications.titleTransferSent,
            Strings.Notifications.titlePaymentReceived,
            Strings.Notifications.titleSubscriptionRenewed,
            Strings.Notifications.titleRefundProcessed,
            Strings.Notifications.titleSubscriptionExpired,
            Strings.Notifications.titleMaintenanceCompleted
        ])

        let images = response.notifications.compactMap { notification -> String? in
            if case let .image(value) = notification.leadingContent {
                return value
            }
            return nil
        }

        let icons = response.notifications.compactMap { notification -> String? in
            if case let .icon(value) = notification.leadingContent {
                return value
            }
            return nil
        }

        #expect(images == ["melissa", "ed"])
        #expect(icons == ["bell", "wrench.and.screwdriver", "calendar"])
        #expect(response.notifications[0].section == Strings.Notifications.sectionToday)
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

    @Test
    func loadNotifications_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.networkConnectionLost)
        let sut = NotificationsCentreService(coreService: coreService)

        do {
            _ = try await sut.loadNotifications()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .networkConnectionLost)
        }
    }
}
