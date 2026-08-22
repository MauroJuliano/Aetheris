import AetherisDesignSystem
import SwiftUI

public struct NotificationsSectionPresentationModel: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let titleSkeletonWidth: CGFloat
    public let items: [NotificationCellModel]
    public let isLoading: Bool

    public init(
        id: String,
        title: String,
        titleSkeletonWidth: CGFloat = 0,
        items: [NotificationCellModel],
        isLoading: Bool = false
    ) {
        self.id = id
        self.title = title
        self.titleSkeletonWidth = titleSkeletonWidth
        self.items = items
        self.isLoading = isLoading
    }
}

public extension NotificationsSectionPresentationModel {
    static func loading(
        title: String,
        titleSkeletonWidth: CGFloat,
        rows: Int
    ) -> Self {
        Self(
            id: title,
            title: title,
            titleSkeletonWidth: titleSkeletonWidth,
            items: (0..<rows).map { index in
                NotificationCellModel(
                    title: "",
                    leadingContent: .icon("bell"),
                    timeLabel: "",
                    hasDivider: index < rows - 1
                )
            },
            isLoading: true
        )
    }

    static func content(
        title: String,
        items: [NotificationCellModel]
    ) -> Self {
        Self(
            id: title,
            title: title,
            items: items
        )
    }
}
