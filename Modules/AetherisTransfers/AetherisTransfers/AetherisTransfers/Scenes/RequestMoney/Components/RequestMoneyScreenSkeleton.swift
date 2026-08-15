import AetherisDesignSystem
import SwiftUI

struct RequestMoneyScreenSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                SkeletonBlock(
                    width: 290,
                    height: 18,
                    radius: 9
                )
                .padding(.top, AppSpacing.medium)

                modeSelectorSkeleton
                formSkeleton
                previewSkeleton
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    private var modeSelectorSkeleton: some View {
        HStack(spacing: AppSpacing.xSmall) {
            SkeletonBlock(height: 48, radius: AppRadius.medium)
            SkeletonBlock(height: 48, radius: AppRadius.medium)
        }
        .padding(AppSpacing.xxxSmall)
        .appCardSurface()
    }

    private var formSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            SkeletonBlock(width: 200, height: 16, radius: 8)
            SkeletonBlock(height: 54, radius: AppRadius.medium)

            HStack(spacing: AppSpacing.medium) {
                ForEach(0..<5, id: \.self) { _ in
                    VStack(spacing: AppSpacing.xSmall) {
                        SkeletonView(.circle)
                            .frame(width: 58, height: 58)

                        SkeletonBlock(width: 60, height: 13, radius: 6)
                        SkeletonBlock(width: 70, height: 10, radius: 5)
                    }
                }
            }

            Divider()

            SkeletonBlock(width: 190, height: 16, radius: 8)
            SkeletonBlock(width: 170, height: 38, radius: 12)

            HStack {
                ForEach(0..<4, id: \.self) { _ in
                    SkeletonBlock(width: 76, height: 42, radius: 21)
                }
            }

            SkeletonBlock(width: 120, height: 16, radius: 8)
            SkeletonBlock(height: 56, radius: AppRadius.medium)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var previewSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            SkeletonBlock(width: 160, height: 18, radius: 8)

            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 80, height: 13, radius: 6)
                    SkeletonBlock(width: 110, height: 22, radius: 9)
                }

                Spacer()

                SkeletonBlock(width: 24, height: 24, radius: 12)

                Spacer()

                SkeletonView(.circle)
                    .frame(width: 42, height: 42)

                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 100, height: 16, radius: 8)
                    SkeletonBlock(width: 90, height: 12, radius: 6)
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    RequestMoneyScreenSkeleton()
        .appScreenBackground()
}
