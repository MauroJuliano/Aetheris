import SwiftUI

struct BalanceViewSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: 72, height: 16, radius: 8)
            SkeletonBlock(width: 180, height: 34, radius: 12)
        }
        .padding(.top, AppSpacing.medium)
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BalanceViewSkeleton()
        .padding()
        .appScreenBackground()
}
