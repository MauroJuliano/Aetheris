import AetherisDesignSystem
import SwiftUI

struct TransactionDetailsSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                headerSkeleton
                informationSkeleton
                specificSectionSkeleton
                supportSkeleton
                actionsSkeleton
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    private var headerSkeleton: some View {
        VStack(spacing: AppSpacing.small) {
            SkeletonView(.circle)
                .frame(width: 92, height: 92)

            SkeletonBlock(width: 150, height: 22, radius: 10)
            SkeletonBlock(width: 130, height: 40, radius: 14)
            SkeletonBlock(width: 100, height: 30, radius: 15)
            SkeletonBlock(width: 180, height: 16, radius: 8)
        }
        .padding(AppSpacing.large)
        .appCardSurface()
    }

    private var informationSkeleton: some View {
        rowsSkeleton(count: 6)
            .padding(.horizontal, AppSpacing.medium)
            .appCardSurface()
    }

    private var specificSectionSkeleton: some View {
        VStack(alignment: .leading, spacing: 0) {
            SkeletonBlock(width: 180, height: 20, radius: 9)
                .padding(.vertical, AppSpacing.medium)

            ForEach(0..<5, id: \.self) { index in
                rowSkeleton

                if index < 4 {
                    Divider().padding(.leading, 52)
                }
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .appCardSurface()
    }

    private func rowsSkeleton(count: Int) -> some View {
        VStack(spacing: 0) {
            ForEach(0..<count, id: \.self) { index in
                rowSkeleton

                if index < count - 1 {
                    Divider().padding(.leading, 52)
                }
            }
        }
    }

    private var rowSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            SkeletonBlock(width: 100, height: 16, radius: 8)

            Spacer()

            SkeletonBlock(width: 130, height: 16, radius: 8)
        }
        .padding(.vertical, AppSpacing.small)
    }

    private var supportSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 100, height: 17, radius: 8)
                SkeletonBlock(width: 190, height: 14, radius: 7)
            }

            Spacer()

            SkeletonBlock(width: 100, height: 40, radius: 20)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var actionsSkeleton: some View {
        HStack {
            ForEach(0..<4, id: \.self) { _ in
                VStack(spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 24, height: 24, radius: 8)
                    SkeletonBlock(width: 60, height: 13, radius: 6)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}
