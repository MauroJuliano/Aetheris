import AetherisDesignSystem
import SwiftUI

struct BeneficiaryListSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                SkeletonBlock(
                    width: 240,
                    height: 54,
                    radius: AppRadius.large
                )
                .padding(.top, AppSpacing.medium)

                recentSkeleton
                allSkeleton
            }
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
        .appScreenBackground()
    }

    private var recentSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: 72, height: 18, radius: 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.medium) {
                    ForEach(0..<5, id: \.self) { _ in
                        VStack(spacing: AppSpacing.small) {
                            SkeletonView(.circle)
                                .frame(width: 58, height: 58)

                            SkeletonBlock(width: 52, height: 13, radius: 6)
                        }
                        .frame(width: 72)
                    }
                }
            }
        }
    }

    private var allSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: 150, height: 18, radius: 8)

            VStack(spacing: AppSpacing.large) {
                ForEach(0..<4, id: \.self) { index in
                    VStack(alignment: .leading, spacing: AppSpacing.small) {
                        SkeletonBlock(width: 14, height: 14, radius: 7)

                        VStack(spacing: AppSpacing.medium) {
                            ForEach(0..<2, id: \.self) { _ in
                                HStack(spacing: AppSpacing.medium) {
                                    SkeletonView(.circle)
                                        .frame(width: 60, height: 60)

                                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                                        SkeletonBlock(
                                            width: nameWidth(for: index),
                                            height: 16,
                                            radius: 8
                                        )

                                        SkeletonBlock(
                                            width: keyWidth(for: index),
                                            height: 12,
                                            radius: 6
                                        )
                                    }

                                    Spacer()

                                    SkeletonBlock(
                                        width: 46,
                                        height: 46,
                                        radius: AppRadius.large
                                    )
                                }
                                .padding(.horizontal, AppSpacing.medium)
                                .padding(.vertical, AppSpacing.medium)
                                .appCardSurface()
                            }
                        }
                    }
                }
            }
        }
    }

    private func nameWidth(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return 96
        case 1:
            return 118
        case 2:
            return 82
        default:
            return 110
        }
    }

    private func keyWidth(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return 196
        case 1:
            return 122
        case 2:
            return 160
        default:
            return 104
        }
    }
}

#Preview {
    BeneficiaryListSkeleton()
        .padding()
        .appScreenBackground()
}
