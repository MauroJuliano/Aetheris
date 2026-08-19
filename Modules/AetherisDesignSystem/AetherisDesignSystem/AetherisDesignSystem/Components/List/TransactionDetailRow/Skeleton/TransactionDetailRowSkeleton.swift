import SwiftUI

struct TransactionDetailRowSkeleton: View {
    let showsChevron: Bool
    let hasSubtitle: Bool

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                SkeletonBlock(
                    width: 86,
                    height: 18,
                    radius: 8
                )

                if hasSubtitle {
                    SkeletonBlock(
                        width: 120,
                        height: 14,
                        radius: 6
                    )
                }
            }

            Spacer(minLength: AppSpacing.small)

            VStack(alignment: .trailing, spacing: AppSpacing.xxxSmall) {
                SkeletonBlock(
                    width: 96,
                    height: 18,
                    radius: 8
                )

                if hasSubtitle {
                    SkeletonBlock(
                        width: 74,
                        height: 14,
                        radius: 6
                    )
                }
            }

            if showsChevron {
                SkeletonBlock(
                    width: 10,
                    height: 18,
                    radius: 5
                )
            }
        }
        .padding(.vertical, AppSpacing.small)
        .frame(minHeight: 60, alignment: .center)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack(spacing: 0) {
        TransactionDetailRowSkeleton(
            showsChevron: true,
            hasSubtitle: true
        )

        Divider()
            .padding(.leading, 52)

        TransactionDetailRowSkeleton(
            showsChevron: false,
            hasSubtitle: false
        )
    }
    .padding(.horizontal, AppSpacing.medium)
    .appCardSurface()
    .padding()
    .appScreenBackground()
}
