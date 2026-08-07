import AetherisDesignSystem
import SwiftUI

struct FinancialSummaryContainerSkeleton: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<4, id: \.self) { index in
                summaryRow(index: index)

                if index < 3 {
                    Divider()
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private func summaryRow(index: Int) -> some View {
        HStack(spacing: AppSpacing.small) {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: index == 0 ? 120 : 150, height: 16, radius: 8)
                SkeletonBlock(width: index == 1 ? 160 : 190, height: 14, radius: 7)
                SkeletonBlock(width: index == 2 ? 64 : 74, height: 18, radius: 9)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: index == 3 ? 72 : 58, height: 18, radius: 9)
                SkeletonBlock(width: index == 2 ? 52 : 44, height: 12, radius: 6)
            }
        }
        .appListCellRow(
            hasDivider: false,
            horizontalPadding: AppSpacing.medium,
            verticalPadding: AppSpacing.medium
        )
    }
}
