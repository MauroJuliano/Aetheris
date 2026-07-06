import AetherisDesignSystem
import SwiftUI

struct TransactionHistorySkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                navBar
                transactionSection(titleWidth: 56, rows: 2)
                transactionSection(titleWidth: 88, rows: 1)
                transactionSection(titleWidth: 78, rows: 2)
            }
        }
        .appScreenBackground()
    }

    private var navBar: some View {
        HStack {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            skeleton(width: 220, height: 28, radius: 14)

            Spacer()
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private func transactionSection(titleWidth: CGFloat, rows: Int) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            skeleton(width: titleWidth, height: 18, radius: 9)
                .padding(.horizontal, AppSpacing.screenHorizontal)

            VStack(spacing: 0) {
                ForEach(0..<rows, id: \.self) { index in
                    HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
                        SkeletonView(.circle)
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                            skeleton(width: index == 0 ? 145 : 120, height: 16, radius: 8)
                            skeleton(width: index == 0 ? 210 : 165, height: 14, radius: 7)
                        }

                        Spacer()

                        skeleton(width: 64, height: 18, radius: 9)
                    }
                    .appListCellRow(
                        hasDivider: index < rows - 1,
                        horizontalPadding: AppSpacing.medium,
                        verticalPadding: AppSpacing.medium
                    )
                }
            }
            .appCardSurface(
                radius: AppRadius.large,
                stroke: Color.border,
                shadow: AppShadow.card
            )
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

#Preview {
    TransactionHistorySkeleton()
}
