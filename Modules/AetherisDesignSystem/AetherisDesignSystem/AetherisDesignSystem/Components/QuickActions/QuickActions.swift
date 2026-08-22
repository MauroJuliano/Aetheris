import SwiftUI


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
