import AetherisDesignSystem
import SwiftUI

struct BeneficiaryDetailsSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                profileSkeleton
                informationSkeleton
                transactionsSkeleton
                removeSkeleton
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    private var profileSkeleton: some View {
        VStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 104, height: 104)

            SkeletonBlock(width: 160, height: 28, radius: 12)
            SkeletonBlock(width: 92, height: 30, radius: 15)

            HStack(spacing: AppSpacing.small) {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(spacing: AppSpacing.xSmall) {
                        SkeletonView(.circle)
                            .frame(
                                width: AppComponentMetrics.mediumCircleSize,
                                height: AppComponentMetrics.mediumCircleSize
                            )

                        SkeletonBlock(width: 65, height: 14, radius: 7)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(AppSpacing.large)
        .appCardSurface()
    }

    private var informationSkeleton: some View {
        VStack(alignment: .leading, spacing: 0) {
            SkeletonBlock(width: 110, height: 20, radius: 9)
                .padding(AppSpacing.medium)

            ForEach(0..<3, id: \.self) { index in
                rowSkeleton

                if index < 2 {
                    Divider().padding(.leading, 56)
                }
            }
        }
        .appCardSurface()
    }

    private var transactionsSkeleton: some View {
        VStack(spacing: 0) {
            HStack {
                SkeletonBlock(width: 110, height: 20, radius: 9)
                Spacer()
                SkeletonBlock(width: 70, height: 16, radius: 8)
            }
            .padding(AppSpacing.medium)

            HStack {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: 60, height: 13, radius: 6)
                        SkeletonBlock(width: 82, height: 20, radius: 9)
                        SkeletonBlock(width: 72, height: 12, radius: 6)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(AppSpacing.medium)

            Divider()

            ForEach(0..<3, id: \.self) { index in
                rowSkeleton

                if index < 2 {
                    Divider().padding(.leading, 64)
                }
            }
        }
        .appCardSurface()
    }

    private var rowSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 42, height: 42)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 140, height: 16, radius: 8)
                SkeletonBlock(width: 190, height: 13, radius: 6)
            }

            Spacer()
            SkeletonBlock(width: 90, height: 17, radius: 8)
        }
        .padding(AppSpacing.medium)
    }

    private var removeSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonBlock(width: 28, height: 28, radius: 8)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 150, height: 17, radius: 8)
                SkeletonBlock(width: 240, height: 13, radius: 6)
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}
