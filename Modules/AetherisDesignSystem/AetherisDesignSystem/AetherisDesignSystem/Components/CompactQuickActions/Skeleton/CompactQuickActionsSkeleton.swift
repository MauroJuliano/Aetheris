import SwiftUI

struct CompactQuickActionsSkeleton: View {
    let itemCount: Int

    var body: some View {
        HStack(spacing: AppSpacing.small) {
            ForEach(0..<max(itemCount, 2), id: \.self) { _ in
                VStack(spacing: AppSpacing.xSmall) {
                    SkeletonView(.circle)
                        .frame(width: AppComponentMetrics.mediumCircleSize, height: AppComponentMetrics.mediumCircleSize)
                    SkeletonBlock(width: 52, height: 12, radius: 6)
                        .frame(minHeight: AppComponentMetrics.glassButtonLabelHeight, alignment: .top)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppSpacing.medium)
            }
        }
        .padding(.vertical, AppSpacing.medium)
        .padding(.horizontal, AppSpacing.small)
        .appCardSurface()
    }
}
