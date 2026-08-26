import AetherisDesignSystem
import SwiftUI

struct TransferBeneficiarySkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 72, height: 72)

            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: 116, height: 18, radius: 9)
                SkeletonBlock(width: 184, height: 12, radius: 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SkeletonBlock(width: 82, height: 44, radius: AppRadius.card)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.medium + AppSpacing.xxxSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
        .appCardSurface()
        .accessibilityHidden(true)
    }
}

#Preview
{
    TransferBeneficiarySkeleton()
        .padding()
        .appScreenBackground()
}
