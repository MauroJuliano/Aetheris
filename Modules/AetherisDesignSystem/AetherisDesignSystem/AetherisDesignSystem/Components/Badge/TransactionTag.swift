import SwiftUI

public struct TransactionTagModel: Hashable {
    public let title: String
    public let icon: String
    public let color: Color

    public init(title: String, icon: String, color: Color) {
        self.title = title
        self.icon = icon
        self.color = color
    }
}

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
