import SwiftUI

struct RecentContactButtonSkeleton: View {
    var body: some View {
        VStack(spacing: AppSpacing.xSmall) {
            SkeletonView(.circle)
                .frame(width: 58, height: 58)

            SkeletonBlock(width: 42, height: 13, radius: 6)
            SkeletonBlock(width: 60, height: 10, radius: 5)
        }
        .frame(width: 82)
        .padding(.vertical, AppSpacing.xSmall)
    }
}

#Preview {
    RecentContactButtonSkeleton()
        .padding()
        .appScreenBackground()
}
