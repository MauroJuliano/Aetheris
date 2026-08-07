import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceScreenSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                SkeletonBlock(width: 280, height: 18, radius: 9)
                    .padding(.top, AppSpacing.medium)

                overviewSkeleton
                noticeSkeleton
                detailsSkeleton
                spendingSkeleton
                FinancialSummaryContainerSkeleton()
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    private var overviewSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            overviewColumn

            Divider()
                .frame(height: 160)

            overviewColumn
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var overviewColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 86, height: 13, radius: 6)
            SkeletonBlock(width: 100, height: 22, radius: 9)
            SkeletonBlock(width: 68, height: 13, radius: 6)

            Spacer()
                .frame(height: AppSpacing.medium)

            SkeletonBlock(width: 90, height: 13, radius: 6)
            SkeletonBlock(width: 80, height: 17, radius: 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var noticeSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 120, height: 17, radius: 8)
                SkeletonBlock(width: 220, height: 14, radius: 7)
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var detailsSkeleton: some View {
        VStack(alignment: .leading, spacing: 0) {
            SkeletonBlock(width: 150, height: 20, radius: 9)
                .padding(AppSpacing.medium)

            ForEach(0..<4, id: \.self) { index in
                HStack(spacing: AppSpacing.medium) {
                    SkeletonView(.circle)
                        .frame(width: 42, height: 42)

                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: index == 3 ? 110 : 145, height: 16, radius: 8)

                        if index < 3 {
                            SkeletonBlock(width: 175, height: 13, radius: 6)
                        }
                    }

                    Spacer()

                    SkeletonBlock(width: 76, height: 17, radius: 8)
                }
                .padding(AppSpacing.medium)

                if index < 3 {
                    Divider()
                        .padding(.leading, 72)
                }
            }
        }
        .appCardSurface()
    }

    private var spendingSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            HStack {
                SkeletonBlock(width: 140, height: 20, radius: 9)

                Spacer()

                SkeletonBlock(width: 105, height: 34, radius: 12)
            }

            HStack(spacing: AppSpacing.large) {
                SkeletonView(.circle)
                    .frame(width: 112, height: 112)

                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    SkeletonBlock(width: 130, height: 14, radius: 7)
                    SkeletonBlock(width: 110, height: 22, radius: 9)
                    SkeletonBlock(width: 180, height: 14, radius: 7)
                    SkeletonBlock(width: 170, height: 14, radius: 7)
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    CurrentInvoiceScreenSkeleton()
        .appScreenBackground()
}
