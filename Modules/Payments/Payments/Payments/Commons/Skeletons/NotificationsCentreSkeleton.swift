import AetherisDesignSystem
import SwiftUI

struct NotificationsCentreSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                navBar
                notificationSection(titleWidth: 56, rows: 3)
                notificationSection(titleWidth: 88, rows: 2)
                notificationSection(titleWidth: 72, rows: 1)
            }
        }
        .appScreenBackground()
    }

    private var navBar: some View {
        HStack {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            SkeletonBlock(width: 230, height: 28, radius: 14)

            Spacer()
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private func notificationSection(titleWidth: CGFloat, rows: Int) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: titleWidth, height: 18, radius: 9)
                .padding(.horizontal, AppSpacing.screenHorizontal)

            VStack(spacing: 0) {
                ForEach(0..<rows, id: \.self) { index in
                    HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
                        SkeletonView(.circle)
                            .frame(width: 46, height: 46)

                        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                            SkeletonBlock(width: index == 2 ? 180 : 220, height: 14, radius: 7)
                            SkeletonBlock(width: index == 1 ? 145 : 110, height: 14, radius: 7)
                        }

                        Spacer()

                        HStack(spacing: AppSpacing.xSmall) {
                            SkeletonView(.circle)
                                .frame(width: AppSpacing.xSmall, height: AppSpacing.xSmall)
                            SkeletonBlock(width: 58, height: 12, radius: 6)
                        }
                    }
                    .appListCellRow(hasDivider: index < rows - 1)
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

}

