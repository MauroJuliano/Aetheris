import SwiftUI

public struct NotificationSectionHeader: View {
    public let title: String
    public let skeletonWidth: CGFloat

    public init(
        title: String,
        skeletonWidth: CGFloat = 72
    ) {
        self.title = title
        self.skeletonWidth = skeletonWidth
    }

    public var body: some View {
        Text(title)
            .foregroundStyle(Color.textPrimary)
            .font(AppTypography.sectionTitle)
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            NotificationSectionHeaderSkeleton(
                width: skeletonWidth
            )
        } else {
            self
        }
    }
}

#Preview {
    NotificationSectionHeader(
        title: "Today",
        skeletonWidth: 56
    )
    .padding()
    .appScreenBackground()
}
