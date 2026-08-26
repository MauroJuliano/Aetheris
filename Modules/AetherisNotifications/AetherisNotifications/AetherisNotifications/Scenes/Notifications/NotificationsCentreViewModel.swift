import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class NotificationsCentreViewModel: ObservableObject {

    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var sections: [NotificationsSectionPresentationModel] = []
    private let service: any NotificationsCentreServicing

    init(service: any NotificationsCentreServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false
        sections = Self.loadingSections()

        do {
            let response = try await service.loadNotifications()
            sections = buildSections(from: response.notifications)
            isEmpty = response.notifications.isEmpty
        } catch {
            errorMessage = "We could not load your notifications."
            sections = []
        }

        isLoading = false
    }

    private func buildSections(
        from notifications: [Notifications]
    ) -> [NotificationsSectionPresentationModel] {
        let order = [
            Strings.Notifications.sectionToday,
            Strings.Notifications.sectionYesterday,
            Strings.Notifications.sectionLastWeek,
            Strings.Notifications.sectionLastMonth,
            Strings.Notifications.sectionOthers
        ]

        let grouped = Dictionary(grouping: notifications) { $0.section }

        let sorted = grouped.keys.sorted {
            (order.firstIndex(of: $0) ?? Int.max) <
            (order.firstIndex(of: $1) ?? Int.max)
        }

        return sorted.map { title in
            let items = grouped[title] ?? []
            let cells = items.enumerated().map { index, item in
                NotificationCellModel(
                    id: item.id,
                    title: item.title,
                    leadingContent: item.leadingContent.asCellContent,
                    timeLabel: NotificationTimeLabelFormatter.label(for: item.date),
                    hasDivider: index < items.count - 1
                )
            }

            return .content(title: title, items: cells)
        }
    }

    private static func loadingSections() -> [NotificationsSectionPresentationModel] {
        [
            .loading(
                title: Strings.Notifications.sectionToday,
                titleSkeletonWidth: 56,
                rows: 3
            ),
            .loading(
                title: Strings.Notifications.sectionYesterday,
                titleSkeletonWidth: 88,
                rows: 2
            ),
            .loading(
                title: Strings.Notifications.sectionLastWeek,
                titleSkeletonWidth: 72,
                rows: 1
            )
        ]
    }
}
