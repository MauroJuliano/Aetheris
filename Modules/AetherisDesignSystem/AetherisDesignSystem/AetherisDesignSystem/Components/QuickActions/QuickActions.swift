import SwiftUI

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

public struct QuickActions: View {
    public let title: String
    public let items: [QuickActionItem]
    public let onItemTap: (QuickActionItem) -> Void

    public init(
        title: String,
        items: [QuickActionItem],
        onItemTap: @escaping (QuickActionItem) -> Void
    ) {
        self.title = title
        self.items = items
        self.onItemTap = onItemTap
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            Text(title)
                .font(AppTypography.headline)
                .foregroundStyle(Color.textPrimary)

            HStack(spacing: AppSpacing.medium) {
                ForEach(items) { item in
                    QuickActionCard(action: item) {
                        onItemTap(item)
                    }
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            QuickActionsSkeleton(
                titleWidth: 190,
                actionsCount: items.count
            )
        } else {
            self
        }
    }
}

#Preview {
    QuickActions(
        title: "What would you like to do?",
        items: [
            .init(
                id: "transfer",
                title: "Transfer",
                subtitle: "Send money",
                icon: "arrow.right.arrow.left"
            ),
            .init(
                id: "request",
                title: "Request",
                subtitle: "Ask for money",
                icon: "arrow.down.left.arrow.up.right"
            ),
            .init(
                id: "more",
                title: "More",
                subtitle: "Other actions",
                icon: "ellipsis"
            )
        ],
        onItemTap: { _ in }
    )
        .padding()
        .appScreenBackground()
}

private struct QuickActionCard: View {
    let action: QuickActionItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: action.icon)
                        .font(.system(size: action.icon == "ellipsis" ? 26 : 30, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                        .frame(width: 36, height: 36, alignment: .leading)

                    Spacer()
                }
                .frame(height: 40)

                Spacer(minLength: AppSpacing.small)

                VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                    Text(action.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(1)

                    if let subtitle = action.subtitle {
                        Text(subtitle)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color.textTertiary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .frame(height: 36, alignment: .bottom)
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.vertical, AppSpacing.medium)
            .frame(maxWidth: .infinity)
            .frame(height: 132)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color.surface)
            )
        }
        .buttonStyle(.plain)
    }
}
