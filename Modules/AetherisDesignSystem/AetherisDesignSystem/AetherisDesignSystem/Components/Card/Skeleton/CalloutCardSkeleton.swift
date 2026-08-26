import SwiftUI

struct CalloutCardSkeleton: View {
    let titleWidth: CGFloat
    let descriptionWidth: CGFloat
    let buttonWidth: CGFloat

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(
                0,
                proxy.size.width - (AppSpacing.medium * 2)
            )

            let resolvedTitleWidth = min(
                titleWidth,
                max(72, contentWidth * 0.24)
            )

            let resolvedDescriptionWidth = min(
                descriptionWidth,
                max(112, contentWidth * 0.48)
            )

            let resolvedButtonWidth = min(
                buttonWidth,
                max(84, contentWidth * 0.22)
            )

            HStack(spacing: AppSpacing.medium) {
                SkeletonView(.circle)
                    .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: resolvedTitleWidth, height: 16, radius: 8)
                    SkeletonBlock(width: resolvedDescriptionWidth, height: 14, radius: 7)
                }
                .layoutPriority(1)

                Spacer(minLength: 0)

                SkeletonBlock(width: resolvedButtonWidth, height: 40, radius: 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(AppSpacing.medium)
            .background(Color.brandPrimaryColor.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        }
        .frame(height: 72)
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        CalloutCardSkeleton(
            titleWidth: 102,
            descriptionWidth: 220,
            buttonWidth: 96
        )
    }
    .padding()
    .appScreenBackground()
}
