import AetherisDesignSystem
import SwiftUI

struct CardLockScreenSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                SkeletonBlock(
                    width: 280,
                    height: 18,
                    radius: 9
                )
                .padding(.top, AppSpacing.medium)

                SkeletonBlock(
                    height: 210,
                    radius: AppRadius.card
                )

                statusSkeleton
                effectsSkeleton

                SkeletonBlock(
                    height: 54,
                    radius: AppRadius.large
                )

                optionsSkeleton
                securitySkeleton
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    private var statusSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 58, height: 58)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(
                    width: 170,
                    height: 17,
                    radius: 8
                )

                SkeletonBlock(
                    width: 220,
                    height: 14,
                    radius: 7
                )
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var effectsSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(
                width: 240,
                height: 18,
                radius: 8
            )

            VStack(spacing: 0) {
                ForEach(0..<4, id: \.self) { index in
                    rowSkeleton

                    if index < 3 {
                        Divider()
                            .padding(.leading, 72)
                    }
                }
            }
            .appCardSurface()
        }
    }

    private var optionsSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(
                width: 120,
                height: 18,
                radius: 8
            )

            VStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { index in
                    rowSkeleton

                    if index < 2 {
                        Divider()
                            .padding(.leading, 72)
                    }
                }
            }
            .appCardSurface()
        }
    }

    private var rowSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 42, height: 42)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(
                    width: 150,
                    height: 16,
                    radius: 8
                )

                SkeletonBlock(
                    width: 210,
                    height: 13,
                    radius: 6
                )
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
    }

    private var securitySkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(
                    width: 150,
                    height: 17,
                    radius: 8
                )

                SkeletonBlock(
                    width: 230,
                    height: 14,
                    radius: 7
                )
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    CardLockScreenSkeleton()
}
