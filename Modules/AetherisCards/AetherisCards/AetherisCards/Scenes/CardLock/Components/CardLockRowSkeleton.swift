import AetherisDesignSystem
import SwiftUI

struct CardLockRowSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle).frame(width: 52, height: 52)
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 150, height: 17, radius: 8)
                SkeletonBlock(width: 220, height: 13, radius: 6)
            }
            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}
