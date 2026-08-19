import SwiftUI

struct AppEmptyStateViewSkeleton: View {
    var body: some View {
        VStack(spacing: AppSpacing.xLarge) {
            SkeletonView(.circle)
                .frame(width: 140, height: 140)

            VStack(spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: 160, height: 20, radius: 9)
                SkeletonBlock(width: 240, height: 16, radius: 8)
                    .padding(.horizontal, AppSpacing.xLarge)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appScreenBackground()
    }
}

#Preview {
    AppEmptyStateViewSkeleton()
}
