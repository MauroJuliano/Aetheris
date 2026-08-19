import SwiftUI

public enum NotificationCellLeadingContent: Hashable {
    case image(String)
    case icon(String)
}

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

public struct NotificationCell: View {
    public let model: NotificationCellModel

    public init(model: NotificationCellModel) {
        self.model = model
    }

    public var body: some View {
        HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            leadingView

            Text(model.title)
                .font(AppTypography.callout)
                .foregroundStyle(Color.textPrimary)
                .bold()
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: AppSpacing.xSmall) {
                Circle()
                    .fill(Color.brandPrimaryColor)
                    .frame(width: AppSpacing.xSmall, height: AppSpacing.xSmall)

                Text(model.timeLabel)
                    .font(AppTypography.footnote)
                    .foregroundStyle(Color.textTertiary)
            }
        }
        .appListCellRow(hasDivider: model.hasDivider)
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            NotificationCellSkeleton()
        } else {
            self
        }
    }

    @ViewBuilder
    private var leadingView: some View {
        switch model.leadingContent {
        case .image(let name):
            Image(name)
                .resizable()
                .scaledToFill()
                .frame(width: 46, height: 46)
                .clipShape(Circle())

        case .icon(let systemName):
            Circle()
                .fill(Color.brandPrimaryColor.opacity(0.12))
                .frame(width: 46, height: 46)
                .overlay {
                    Image(systemName: systemName)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
        }
    }
}

#Preview {
    NotificationCell(
        model: .init(
            title: "Payment received from Sophie",
            leadingContent: .image("sophie"),
            timeLabel: "2h ago",
            hasDivider: false
        )
    )
    .padding()
    .appScreenBackground()
}
