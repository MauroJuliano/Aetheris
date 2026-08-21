import SwiftUI

struct ContactCardRowSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 110, height: 16, radius: 8)
                SkeletonBlock(width: 180, height: 12, radius: 6)
            }

            Spacer(minLength: AppSpacing.small)

            SkeletonBlock(width: 46, height: 46, radius: AppRadius.large)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    ContactCardRowSkeleton()
        .padding()
        .appScreenBackground()
}
