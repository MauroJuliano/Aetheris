import Foundation
import Testing
import AetherisDesignSystem
@testable import AetherisNotifications

@Suite("NotificationsSectionPresentationModel")
struct NotificationsSectionPresentationModelTests {
    @Test
    func loading_factoryBuildsSkeletonSection() {
        let sut = NotificationsSectionPresentationModel.loading(
            title: Strings.Notifications.sectionToday,
            titleSkeletonWidth: 56,
            rows: 3
        )

        #expect(sut.id == Strings.Notifications.sectionToday)
        #expect(sut.title == Strings.Notifications.sectionToday)
        #expect(sut.titleSkeletonWidth == 56)
        #expect(sut.isLoading)
        #expect(sut.items.count == 3)
        #expect(sut.items.last?.hasDivider == false)
    }

    @Test
    func content_factoryBuildsPresentationSection() {
        let items = [
            NotificationCellModel(
                title: "Transfer sent",
                leadingContent: .image("sophie"),
                timeLabel: "2h ago",
                hasDivider: true
            )
        ]

        let sut = NotificationsSectionPresentationModel.content(
            title: Strings.Notifications.sectionYesterday,
            items: items
        )

        #expect(sut.id == Strings.Notifications.sectionYesterday)
        #expect(sut.title == Strings.Notifications.sectionYesterday)
        #expect(!sut.isLoading)
        #expect(sut.items == items)
    }
}
