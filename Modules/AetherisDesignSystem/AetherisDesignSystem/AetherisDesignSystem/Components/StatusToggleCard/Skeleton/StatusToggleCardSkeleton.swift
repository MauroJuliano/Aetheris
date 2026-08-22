import SwiftUI

struct StatusToggleCardSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle).frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 150, height: 17, radius: 8)
                SkeletonBlock(width: 210, height: 14, radius: 7)
            }
            Spacer()
            SkeletonBlock(width: 52, height: 30, radius: 15)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}
