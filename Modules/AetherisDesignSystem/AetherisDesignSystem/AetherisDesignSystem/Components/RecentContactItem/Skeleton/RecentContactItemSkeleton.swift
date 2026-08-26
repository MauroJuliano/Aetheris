import SwiftUI

struct RecentContactItemSkeleton: View {
    var body: some View {
        VStack(spacing: AppSpacing.small) {
            SkeletonView(.circle)
                .frame(width: 58, height: 58)

            SkeletonBlock(width: 42, height: 13, radius: 6)
        }
        .frame(width: 72)
        .padding(.vertical, AppSpacing.xSmall)
    }
}

#Preview {
    RecentContactItemSkeleton()
        .padding()
        .appScreenBackground()
}
