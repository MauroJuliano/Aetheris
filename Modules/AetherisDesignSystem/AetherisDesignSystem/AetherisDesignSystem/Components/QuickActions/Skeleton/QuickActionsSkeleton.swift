import SwiftUI

struct QuickActionsSkeleton: View {
    let titleWidth: CGFloat
    let actionsCount: Int

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(
                0,
                proxy.size.width - (AppSpacing.medium * 2)
            )

            let actionsSpacing = AppSpacing.medium * CGFloat(max(actionsCount - 1, 0))
            let cardWidth = max(
                0,
                (contentWidth - actionsSpacing) / CGFloat(max(actionsCount, 1))
            )

            let resolvedTitleWidth = min(
                titleWidth,
                max(96, contentWidth * 0.34)
            )

            VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
                SkeletonBlock(width: resolvedTitleWidth, height: 18, radius: 9)

                HStack(spacing: AppSpacing.medium) {
                    ForEach(0..<actionsCount, id: \.self) { _ in
                        QuickActionSkeletonCard(
                            cardWidth: cardWidth
                        )
                        .frame(width: cardWidth, alignment: .topLeading)
                    }
                }
            }
            .frame(width: proxy.size.width, alignment: .leading)
            .padding(AppSpacing.medium)
            .appCardSurface()
        }
        .frame(height: 164)
    }
}

private struct QuickActionSkeletonCard: View {
    let cardWidth: CGFloat

    var body: some View {
        let availableWidth = max(
            0,
            cardWidth - (AppSpacing.large * 2)
        )

        let titleWidth = min(
            82,
            max(48, availableWidth * 0.72)
        )

        let subtitleWidth = min(
            100,
            max(56, availableWidth * 0.88)
        )

        VStack(alignment: .leading, spacing: 0) {
            HStack {
                SkeletonView(.circle)
                    .frame(width: 36, height: 36)

                Spacer(minLength: 0)
            }
            .frame(height: 40)

            Spacer(minLength: AppSpacing.small)

            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: titleWidth, height: 14, radius: 7)
                SkeletonBlock(width: subtitleWidth, height: 12, radius: 6)
            }
            .frame(height: 36, alignment: .bottom)
        }
        .padding(.horizontal, AppSpacing.large)
        .padding(.vertical, AppSpacing.medium)
        .frame(height: 132, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color.surface)
        )
        .clipped()
    }
}

#Preview {
    QuickActionsSkeleton(titleWidth: 190, actionsCount: 3)
        .padding()
        .appScreenBackground()
}
