import AetherisDesignSystem
import SwiftUI

struct RequestMoneyPreviewSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            SkeletonBlock(width: 160, height: 18, radius: 8)

            HStack(spacing: AppSpacing.medium) {
                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    SkeletonBlock(width: 80, height: 13, radius: 6)
                    SkeletonBlock(width: 110, height: 22, radius: 9)
                    SkeletonBlock(width: 90, height: 12, radius: 6)
                }

                Spacer()

                SkeletonBlock(width: 24, height: 24, radius: 12)

                Spacer()

                SkeletonView(.circle)
                    .frame(width: 42, height: 42)

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    SkeletonBlock(width: 100, height: 16, radius: 8)
                    SkeletonBlock(width: 90, height: 12, radius: 6)
                }
            }

            SkeletonBlock(height: 1, radius: 0)
            SkeletonBlock(width: 180, height: 16, radius: 8)
        }
        .padding(AppSpacing.medium)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}
