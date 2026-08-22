import AetherisDesignSystem
import SwiftUI

struct FinancialSummarySkeleton: View {
    let hasDivider: Bool

    var body: some View {
        HStack {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)
                .padding(.trailing, AppSpacing.xxSmall)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 145, height: 16, radius: 8)
                SkeletonBlock(width: 170, height: 14, radius: 7)
                SkeletonBlock(width: 72, height: 20, radius: 10)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: 64, height: 18, radius: 9)
                SkeletonBlock(width: 92, height: 12, radius: 6)
            }
        }
        .appListCellRow(
            hasDivider: hasDivider,
            horizontalPadding: AppSpacing.medium,
            verticalPadding: AppSpacing.medium
        )
    }
}

#Preview {
    VStack(spacing: 0) {
        FinancialSummarySkeleton(hasDivider: true)
        FinancialSummarySkeleton(hasDivider: false)
    }
    .padding()
    .appScreenBackground()
}
