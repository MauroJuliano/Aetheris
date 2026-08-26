import SwiftUI

struct AnalyticsCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            VStack(alignment: .leading, spacing: AppSpacing.small) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: 102, height: 14, radius: 7)

                        HStack(spacing: AppSpacing.small) {
                            SkeletonBlock(width: 108, height: 24, radius: 12)
                            SkeletonBlock(width: 64, height: 20, radius: 10)
                        }
                    }

                    Spacer()

                    SkeletonBlock(width: 92, height: 28, radius: 14)
                }

                SkeletonBlock(width: 172, height: 11, radius: 6)
            }

            SkeletonBlock(height: 126, radius: AppRadius.medium)
                .padding(.top, AppSpacing.xxxSmall)

            HStack(spacing: AppSpacing.medium) {
                ForEach(0..<4, id: \.self) { index in
                    VStack(spacing: AppSpacing.xxxSmall) {
                        SkeletonView(.rect)
                            .frame(width: 34, height: 34)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                            )

                        SkeletonBlock(width: index == 1 ? 58 : 44, height: 10, radius: 5)
                        SkeletonBlock(width: index == 1 ? 52 : 40, height: 12, radius: 6)
                        SkeletonBlock(width: index == 1 ? 34 : 28, height: 10, radius: 5)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, AppSpacing.xxSmall)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    AnalyticsCardSkeleton()
        .padding()
        .appScreenBackground()
}
