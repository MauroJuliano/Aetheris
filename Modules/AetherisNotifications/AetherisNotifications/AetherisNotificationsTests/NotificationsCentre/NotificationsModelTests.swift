import Foundation
import Testing
@testable import AetherisNotifications

@Suite("NotificationsModel")
struct NotificationsModelTests {
    @Test
    func leadingContent_roundTripsCodableForImageAndIconCases() throws {
        let values: [NotificationLeadingContent] = [
            .image("sophie"),
            .icon("bell")
        ]

        for value in values {
            let data = try JSONEncoder().encode(value)
            let decoded = try JSONDecoder().decode(NotificationLeadingContent.self, from: data)

            #expect(decoded == value)
        }
    }

    @Test(arguments: [
        (0, Strings.Notifications.sectionToday),
        (-1, Strings.Notifications.sectionYesterday),
        (-3, Strings.Notifications.sectionLastWeek),
        (-20, Strings.Notifications.sectionLastMonth),
        (-60, Strings.Notifications.sectionOthers)
    ])
    func notifications_sectionClassifiesDate(
        dayOffset: Int,
        expectedSection: String
    ) {
        let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
        let notification = Notifications(
            title: "Test",
            leadingContent: .icon("bell"),
            date: date,
            hasDivider: true
        )

        #expect(notification.section == expectedSection)
    }

    @Test
    func responseMock_containsExpectedUnreadCountAndMixedContent() {
        let response = NotificationsCentreResponse.mock

        #expect(response.unreadCount == 3)
        #expect(response.notifications.count == 6)
        #expect(response.notifications.contains { notification in
            if case .image = notification.leadingContent {
                return true
            }
            return false
        })
        #expect(response.notifications.contains { notification in
            if case .icon = notification.leadingContent {
                return true
            }
            return false
        })
    }
}
