import Foundation

public struct NotificationCellModel: Identifiable, Hashable {
    public let id: UUID
    public let title: String
    public let leadingContent: NotificationCellLeadingContent
    public let timeLabel: String
    public let hasDivider: Bool

    public init(
        id: UUID = UUID(),
        title: String,
        leadingContent: NotificationCellLeadingContent,
        timeLabel: String,
        hasDivider: Bool
    ) {
        self.id = id
        self.title = title
        self.leadingContent = leadingContent
        self.timeLabel = timeLabel
        self.hasDivider = hasDivider
    }
}
