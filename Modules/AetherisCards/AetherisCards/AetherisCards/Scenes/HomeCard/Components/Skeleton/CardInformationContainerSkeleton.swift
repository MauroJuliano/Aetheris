import AetherisDesignSystem
import SwiftUI

struct CardInformationContainerSkeleton: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: AppSpacing.medium) {
                summaryColumn

                Divider()
                    .frame(height: 104)

                summaryColumn
            }
            .padding(AppSpacing.medium)

            Divider()
                .padding(.horizontal, AppSpacing.medium)

            HStack(spacing: AppSpacing.small) {
                SkeletonView(.circle)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 90, height: 14, radius: 7)
                    SkeletonBlock(width: 110, height: 16, radius: 8)
                }

                Spacer()
            }
            .padding(AppSpacing.medium)
        }
        .appCardSurface()
    }

    private var summaryColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 120, height: 14, radius: 7)
            SkeletonBlock(width: 100, height: 22, radius: 9)
            SkeletonBlock(width: 130, height: 8, radius: 4)
            SkeletonBlock(width: 90, height: 14, radius: 7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CardInformationContainerSkeleton()
        .padding()
        .appScreenBackground()
}
