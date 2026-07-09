import AetherisDesignSystem
import SwiftUI

struct ViewReportSkeleton: View {
    private let categoryWidths: [(title: CGFloat, amount: CGFloat, percentage: CGFloat)] = [
        (64, 48, 30),
        (42, 56, 24),
        (58, 50, 26),
        (78, 46, 28)
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                navBar
                summaryCard
                chartCard
                categoriesCard
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.top, AppSpacing.xSmall)
            .padding(.bottom, AppSpacing.xxLarge)
        }
        .appScreenBackground()
    }

    private var navBar: some View {
        HStack(alignment: .center) {
            SkeletonView(.circle)
                .frame(width: AppComponentMetrics.navigationIconButtonSize, height: AppComponentMetrics.navigationIconButtonSize)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 110, height: 18, radius: 9)
                SkeletonBlock(width: 170, height: 28, radius: 14)
            }

            Spacer()
        }
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 96, height: 14, radius: 7)
                    SkeletonBlock(width: 140, height: 28, radius: 14)
                }

                Spacer()

                SkeletonBlock(width: 76, height: 26, radius: 13)
            }

            HStack(spacing: AppSpacing.small) {
                ForEach(0..<3, id: \.self) { index in
                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: index == 0 ? 48 : 36, height: 12, radius: 6)
                        SkeletonBlock(width: index == 1 ? 70 : 54, height: 18, radius: 9)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface(
            radius: AppRadius.large,
            stroke: Color.border,
            shadow: AppShadow.card
        )
    }

    private var chartCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            SkeletonBlock(width: 122, height: 18, radius: 9)

            SkeletonView(.rect)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous))
        }
        .padding(AppSpacing.medium)
        .appCardSurface(
            radius: AppRadius.large,
            stroke: Color.border,
            shadow: AppShadow.card
        )
    }

    private var categoriesCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            SkeletonBlock(width: 84, height: 18, radius: 9)

            VStack(spacing: 0) {
                ForEach(categoryWidths.indices, id: \.self) { index in
                    HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
                        SkeletonView(.circle)
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                            SkeletonBlock(width: categoryWidths[index].title, height: 12, radius: 6)
                            SkeletonBlock(width: categoryWidths[index].amount, height: 14, radius: 7)
                            SkeletonBlock(width: categoryWidths[index].percentage, height: 10, radius: 5)
                        }

                        Spacer()
                    }
                    .appListCellRow(
                        hasDivider: index < categoryWidths.count - 1,
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
    }
}

#Preview {
    ViewReportSkeleton()
}
