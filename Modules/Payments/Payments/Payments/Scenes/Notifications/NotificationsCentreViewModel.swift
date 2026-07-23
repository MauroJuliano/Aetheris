import Foundation
import SwiftUI

@MainActor
final class NotificationsCentreViewModel: ObservableObject {

    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var sections: [Section] = []
    private let service: any NotificationsCentreServicing

    init(service: any NotificationsCentreServicing) {
        self.service = service
    }

    struct Section: Identifiable {
        let id: String
        let title: String
        let items: [Notifications]
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            let notifications = try await service.loadNotifications()
            buildSections(from: notifications)
            isEmpty = notifications.isEmpty
        } catch {
            errorMessage = "We could not load your notifications."
        }

        isLoading = false
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
