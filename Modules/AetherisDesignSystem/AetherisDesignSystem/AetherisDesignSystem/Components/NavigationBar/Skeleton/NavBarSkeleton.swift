import SwiftUI

struct NavBarSkeleton: View {
    let hasNotifications: Bool
    let hasBackButton: Bool

    var body: some View {
        HStack {
            if hasBackButton {
                SkeletonView(.circle)
                    .frame(width: AppComponentMetrics.navigationIconButtonSize, height: AppComponentMetrics.navigationIconButtonSize)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 120, height: 16, radius: 8)
                SkeletonBlock(width: 160, height: 22, radius: 10)
            }

            Spacer()

            if hasNotifications {
                SkeletonView(.circle)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    VStack(spacing: AppSpacing.xLarge) {
        NavBarSkeleton(hasNotifications: true, hasBackButton: true)
        NavBarSkeleton(hasNotifications: false, hasBackButton: true)
    }
    .padding()
    .appScreenBackground()
}
