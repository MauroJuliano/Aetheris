import Foundation

public struct QuickActionItem: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let subtitle: String?
    public let icon: String

    public init(
        id: String,
        title: String,
        subtitle: String? = nil,
        icon: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
}
