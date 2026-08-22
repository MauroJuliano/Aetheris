import SwiftUI

struct ServiceCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            SkeletonView(.rect)
                .frame(width: 44, height: 44)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: AppRadius.large,
                        style: .continuous
                    )
                )

            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: 118, height: 16, radius: 8)
                SkeletonBlock(width: 96, height: 12, radius: 6)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        .padding(AppSpacing.medium)
        .appCardSurface(
            radius: AppRadius.large,
            stroke: Color.border,
            shadow: AppShadow.card
        )
    }
}

#Preview {
    ServiceCardSkeleton()
        .padding()
        .appScreenBackground()
}
