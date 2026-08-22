import SwiftUI

struct CreditCardViewSkeleton: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.textTertiary.opacity(0.08),
                    Color.textTertiary.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: AppCardMetrics.creditCardOverlayOneSize, height: AppCardMetrics.creditCardOverlayOneSize)
                    .offset(x: -170, y: 110)

                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: AppCardMetrics.creditCardOverlayTwoSize, height: AppCardMetrics.creditCardOverlayTwoSize)
                    .offset(x: 190, y: 150)

                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: AppCardMetrics.creditCardOverlayThreeSize, height: AppCardMetrics.creditCardOverlayThreeSize)
                    .offset(x: 190, y: -60)
            }

            VStack(alignment: .leading, spacing: AppCreditCardStyle.contentSpacing) {
                HStack {
                    SkeletonBlock(width: 24, height: 24, radius: 8)
                    Spacer()
                    SkeletonBlock(width: 24, height: 24, radius: 8)
                }

                SkeletonBlock(width: 180, height: 22, radius: 10)
                SkeletonBlock(width: 110, height: 14, radius: 7)

                Spacer()

                HStack {
                    SkeletonBlock(width: 110, height: 16, radius: 8)
                    Spacer()
                    SkeletonBlock(width: 64, height: 16, radius: 8)
                }
            }
            .padding(AppSpacing.xLarge)
            .frame(width: AppCardMetrics.creditCardSize.width, height: AppCardMetrics.creditCardSize.height)
        }
        .frame(width: AppCardMetrics.creditCardSize.width, height: AppCardMetrics.creditCardSize.height)
        .clipShape(RoundedRectangle(cornerRadius: AppCardMetrics.creditCardBorderRadius))
        .appShadow(AppShadowStyle(color: .black.opacity(0.12), radius: 10))
    }
}

#Preview {
    CreditCardViewSkeleton()
        .padding()
        .appScreenBackground()
}
