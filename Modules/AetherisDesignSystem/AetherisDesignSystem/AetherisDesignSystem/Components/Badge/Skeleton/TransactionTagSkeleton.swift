import SwiftUI

struct TransactionTagSkeleton: View {
    let color: Color

    var body: some View {
        HStack(spacing: AppSpacing.xxSmall) {
            SkeletonBlock(width: AppBadgeStyle.iconSize, height: AppBadgeStyle.iconSize, radius: AppBadgeStyle.iconSize / 2)
            SkeletonBlock(width: 64, height: 14, radius: 7)
        }
        .appCapsuleBadge(foreground: color, background: color.opacity(0.12))
    }
}

#Preview {
    TransactionTagSkeleton(color: .green)
        .padding()
        .appScreenBackground()
}
