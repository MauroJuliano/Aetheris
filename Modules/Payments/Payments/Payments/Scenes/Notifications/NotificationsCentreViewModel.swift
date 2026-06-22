import SwiftUI

@MainActor
final class NotificationsCentreViewModel: ObservableObject {

    @Published private(set) var sections: [Section] = []

    struct Section: Identifiable {
        let id: String
        let title: String
        let items: [Notifications]
    }

    func load() async {
        let data = Notifications.mock
        buildSections(from: data)
    }

    private func buildSections(from notifications: [Notifications]) {

        let order = ["Today", "Yesterday", "Last Week", "Last Month", "Others"]

        let grouped = Dictionary(grouping: notifications) { $0.section }

        let sorted = grouped.keys.sorted {
            (order.firstIndex(of: $0) ?? Int.max) <
            (order.firstIndex(of: $1) ?? Int.max)
        }

        sections = sorted.map {
            Section(id: $0,
                    title: $0,
                    items: grouped[$0] ?? [])
        }
    }
}
