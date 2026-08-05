import Foundation

struct QuickActionItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
}
