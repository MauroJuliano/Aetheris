import AetherisDesignSystem
import SwiftUI

struct TransactionTag: View {
    let type: TransactionType

    var body: some View {
        HStack(spacing: AppSpacing.xxSmall) {
            Image(systemName: type.icon)
                .font(.system(size: AppBadgeStyle.iconSize, weight: .bold))

            Text(type.title)
                .font(AppBadgeStyle.font)
        }
        .appCapsuleBadge(foreground: type.color, background: type.color.opacity(0.12))
    }
}

