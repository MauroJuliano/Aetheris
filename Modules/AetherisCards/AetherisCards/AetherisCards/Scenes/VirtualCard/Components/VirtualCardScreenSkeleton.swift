import AetherisDesignSystem
import SwiftUI

struct VirtualCardScreenSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                SkeletonBlock(width: 280, height: 18, radius: 9)
                    .padding(.top, AppSpacing.medium)

                SkeletonBlock(height: 210, radius: AppRadius.card)

                quickActionsSkeleton
                statusSkeleton
                usageSkeleton
                FinancialSummaryContainerSkeleton()
                securitySkeleton
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.large)
        }
    }

    private var quickActionsSkeleton: some View {
        HStack {
            ForEach(0..<3, id: \.self) { _ in
                VStack(spacing: AppSpacing.xSmall) {
                    SkeletonView(.circle)
                        .frame(
                            width: AppComponentMetrics.mediumCircleSize,
                            height: AppComponentMetrics.mediumCircleSize
                        )

                    SkeletonBlock(width: 80, height: 14, radius: 7)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var statusSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 150, height: 17, radius: 8)
                SkeletonBlock(width: 210, height: 14, radius: 7)
            }

            Spacer()

            SkeletonBlock(width: 52, height: 30, radius: 15)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var usageSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            usageColumn

            Divider()
                .frame(height: 100)

            usageColumn
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var usageColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 110, height: 14, radius: 7)
            SkeletonBlock(width: 120, height: 22, radius: 9)
            SkeletonBlock(width: 130, height: 8, radius: 4)
            SkeletonBlock(width: 100, height: 14, radius: 7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var securitySkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 240, height: 14, radius: 7)
                SkeletonBlock(width: 80, height: 14, radius: 7)
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    VirtualCardScreenSkeleton()
        .appScreenBackground()
}
