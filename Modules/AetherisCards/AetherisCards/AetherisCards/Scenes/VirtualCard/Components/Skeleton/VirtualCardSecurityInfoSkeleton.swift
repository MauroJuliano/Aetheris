import AetherisDesignSystem
import SwiftUI

struct VirtualCardSecurityInfoSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 240, height: 14, radius: 7)
                SkeletonBlock(width: 80, height: 14, radius: 7)
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    VirtualCardSecurityInfoSkeleton()
        .padding()
        .appScreenBackground()
}
