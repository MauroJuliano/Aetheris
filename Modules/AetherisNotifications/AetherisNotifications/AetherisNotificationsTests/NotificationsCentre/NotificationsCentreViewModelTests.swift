import Foundation
import Testing
@testable import AetherisNotifications

@MainActor
@Suite("NotificationsCentreViewModel")
struct NotificationsCentreViewModelTests {
    @Test
    func initialState_isLoadingAndEmpty() {
        let sut = NotificationsCentreViewModel(service: NotificationsServiceSpy(result: .success(.init(unreadCount: 0, notifications: []))))

        #expect(sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.sections.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_groupsNotificationsInDisplayOrder() async {
        let calendar = Calendar.current
        let notifications = [
            Self.makeNotification(title: "Old", date: calendar.date(byAdding: .month, value: -2, to: Date())!),
            Self.makeNotification(title: "Today", date: Date()),
            Self.makeNotification(title: "Yesterday", date: calendar.date(byAdding: .day, value: -1, to: Date())!)
        ]
        let sut = NotificationsCentreViewModel(service: NotificationsServiceSpy(result: .success(.init(unreadCount: 1, notifications: notifications))))

        await sut.load()

        #expect(sut.sections.map(\.title) == [
            Strings.Notifications.sectionToday,
            Strings.Notifications.sectionYesterday,
            Strings.Notifications.sectionOthers
        ])
        #expect(sut.sections.flatMap(\.items).count == 3)
        #expect(!sut.isEmpty)
        #expect(!sut.isLoading)
    }

    @Test
    func load_groupsNotificationsAcrossAllSections_andKeepsOrdering() async {
        let calendar = Calendar.current
        let notifications = [
            Self.makeNotification(title: "Today", date: Date()),
            Self.makeNotification(title: "Yesterday", date: calendar.date(byAdding: .day, value: -1, to: Date())!),
            Self.makeNotification(title: "Week", date: calendar.date(byAdding: .day, value: -3, to: Date())!),
            Self.makeNotification(title: "Month", date: calendar.date(byAdding: .day, value: -20, to: Date())!),
            Self.makeNotification(title: "Older", date: calendar.date(byAdding: .month, value: -2, to: Date())!)
        ]
        let sut = NotificationsCentreViewModel(service: NotificationsServiceSpy(result: .success(.init(unreadCount: 1, notifications: notifications))))

        await sut.load()

        #expect(sut.sections.map(\.title) == [
            Strings.Notifications.sectionToday,
            Strings.Notifications.sectionYesterday,
            Strings.Notifications.sectionLastWeek,
            Strings.Notifications.sectionLastMonth,
            Strings.Notifications.sectionOthers
        ])
        #expect(sut.sections.flatMap(\.items).map(\.title) == [
            "Today",
            "Yesterday",
            "Week",
            "Month",
            "Older"
        ])
    }

    @Test
    func load_marksEmpty_whenServiceReturnsNoNotifications() async {
        let sut = NotificationsCentreViewModel(service: NotificationsServiceSpy(result: .success(.init(unreadCount: 0, notifications: []))))

        await sut.load()

        #expect(sut.isEmpty)
        #expect(sut.sections.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_setsErrorMessage_whenServiceFails() async {
        let sut = NotificationsCentreViewModel(service: NotificationsServiceSpy(result: .failure(URLError(.timedOut))))

        await sut.load()

        #expect(sut.sections.isEmpty)
        #expect(sut.errorMessage == "We could not load your notifications.")
        #expect(!sut.isLoading)
    }

    @Test
    func load_setsErrorAndRecoversOnRetry() async {
        let service = NotificationsServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success(.init(unreadCount: 1, notifications: [Self.makeNotification(title: "Recovered", date: Date())]))
        ])
        let sut = NotificationsCentreViewModel(service: service)

        await sut.load()
        #expect(sut.errorMessage != nil)

        await sut.load()

        #expect(sut.errorMessage == nil)
        #expect(sut.sections.flatMap(\.items).map(\.title) == ["Recovered"])
        #expect(service.loadCalls == 2)
    }

    private static func makeNotification(title: String, date: Date) -> Notifications {
        Notifications(title: title, leadingContent: .icon("bell"), date: date, hasDivider: true)
    }
}

private final class NotificationsServiceSpy: NotificationsCentreServicing {
    enum Result { case success(NotificationsCentreResponse), failure(Error) }
    private var results: [Result]
    private(set) var loadCalls = 0

    init(result: Result) { results = [result] }
    init(results: [Result]) { self.results = results }

    func loadNotifications() async throws -> NotificationsCentreResponse {
        loadCalls += 1
        switch results.removeFirst() {
        case let .success(response): return response
        case let .failure(error): throw error
        }
    }
}
