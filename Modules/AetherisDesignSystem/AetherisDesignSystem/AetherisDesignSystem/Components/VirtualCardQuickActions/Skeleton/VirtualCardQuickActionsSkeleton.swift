import SwiftUI

struct VirtualCardQuickActionsSkeleton: View {
    let actionsCount: Int

    var body: some View {
        HStack(spacing: AppSpacing.small) {
            ForEach(0..<actionsCount, id: \.self) { index in
                VStack(spacing: AppSpacing.xSmall) {
                    SkeletonView(.circle)
                        .frame(width: AppComponentMetrics.mediumCircleSize, height: AppComponentMetrics.mediumCircleSize)

                    SkeletonBlock(width: index == 1 ? 88 : 62, height: AppComponentMetrics.glassButtonLabelHeight, radius: 8)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, AppSpacing.small)
        .padding(.vertical, AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    VirtualCardQuickActionsSkeleton(actionsCount: 3)
        .padding()
        .appScreenBackground()
}
