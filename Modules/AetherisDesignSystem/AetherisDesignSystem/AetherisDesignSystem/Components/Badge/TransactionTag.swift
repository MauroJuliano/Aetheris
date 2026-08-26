import SwiftUI

public struct TransactionTag: View {
    public let model: TransactionTagModel

    public init(model: TransactionTagModel) {
        self.model = model
    }

    public var body: some View {
        HStack(spacing: AppSpacing.xxSmall) {
            Image(systemName: model.icon)
                .font(.system(size: AppBadgeStyle.iconSize, weight: .bold))

            Text(model.title)
                .font(AppBadgeStyle.font)
        }
        .appCapsuleBadge(foreground: model.color, background: model.color.opacity(0.12))
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            TransactionTagSkeleton(color: model.color)
        } else {
            self
        }
    }
}

#Preview {
    HStack {
        TransactionTag(
            model: .init(title: "Income", icon: "arrow.down", color: .green)
        )
        TransactionTag(
            model: .init(title: "Expense", icon: "arrow.up", color: .red)
        )
    }
    .padding()
    .appScreenBackground()
}
