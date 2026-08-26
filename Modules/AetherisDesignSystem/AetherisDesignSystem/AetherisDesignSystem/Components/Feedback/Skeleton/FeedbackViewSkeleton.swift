import SwiftUI

struct FeedbackViewSkeleton: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                SkeletonView(.circle)
                    .frame(width: 170, height: 170)

                VStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    SkeletonBlock(width: 210, height: 24, radius: 10)
                    SkeletonBlock(width: 260, height: 16, radius: 8)
                }
            }

            Spacer()

            VStack(spacing: AppSpacing.large - AppSpacing.xxxSmall) {
                SkeletonBlock(width: 180, height: 50, radius: AppRadius.large)
                SkeletonBlock(width: 140, height: 44, radius: AppRadius.large)
            }
            .padding(.horizontal, AppSpacing.xLarge)
            .padding(.bottom, AppSpacing.xxLarge + AppSpacing.xxxSmall)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appScreenBackground()
    }
}

#Preview {
    FeedbackViewSkeleton()
}
