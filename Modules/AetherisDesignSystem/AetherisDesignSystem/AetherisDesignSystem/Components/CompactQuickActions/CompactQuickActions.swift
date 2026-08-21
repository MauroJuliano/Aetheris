import SwiftUI

public struct CompactQuickActions: View {
    public let items: [CompactQuickActionItem]
    public let onItemTap: (CompactQuickActionItem) -> Void

    public init(items: [CompactQuickActionItem], onItemTap: @escaping (CompactQuickActionItem) -> Void) {
        self.items = items
        self.onItemTap = onItemTap
    }

    public var body: some View {
        HStack(spacing: AppSpacing.small) {
            ForEach(items.prefix(4)) { item in
                Button { onItemTap(item) } label: {
                    VStack(spacing: AppSpacing.xSmall) {
                        ZStack {
                            Circle()
                                .fill(Color.brandPrimaryColor.opacity(0.08))
                                .frame(width: AppComponentMetrics.mediumCircleSize, height: AppComponentMetrics.mediumCircleSize)

                            Image(systemName: item.icon)
                                .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                                .foregroundStyle(Color.brandPrimaryColor)
                        }

                        Text(item.title)
                            .font(AppTypography.cellCaption)
                            .bold()
                            .foregroundStyle(Color.textPrimary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, minHeight: AppComponentMetrics.glassButtonLabelHeight, alignment: .top)
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
                .accessibilityLabel(item.title.replacingOccurrences(of: "\n", with: " "))
            }
        }
        .padding(.vertical, AppSpacing.medium)
        .padding(.horizontal, AppSpacing.small)
        .appCardSurface()
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable { CompactQuickActionsSkeleton(itemCount: items.count) } else { self }
    }
}
