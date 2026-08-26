import AetherisDesignSystem
import SwiftUI

struct VirtualCardViewSkeleton: View {
    var body: some View {
        ZStack {
            cardBackground

            VStack(alignment: .leading, spacing: 0) {
                header

                Spacer()

                cardNumber

                Spacer()

                footer
            }
            .padding(AppSpacing.large)
        }
        .aspectRatio(1.58, contentMode: .fit)
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        Color.brandPrimaryColor.opacity(0.22),
                        Color.brandSecondaryColor.opacity(0.22)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                decorativeShapes
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: AppRadius.card,
                            style: .continuous
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.08), radius: 16, y: 8)
    }

    private var decorativeShapes: some View {
        GeometryReader { proxy in
            Circle()
                .fill(Color.white.opacity(0.08))
                .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                .offset(x: proxy.size.width * 0.55, y: -proxy.size.height * 0.2)

            Circle()
                .fill(Color.black.opacity(0.06))
                .frame(width: proxy.size.width * 0.8, height: proxy.size.width * 0.8)
                .offset(x: -proxy.size.width * 0.25, y: proxy.size.height * 0.45)
        }
    }

    private var header: some View {
        HStack {
            SkeletonBlock(width: 74, height: 20, radius: 6)

            Spacer()

            SkeletonView(.circle)
                .frame(width: 44, height: 44)
        }
    }

    private var cardNumber: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 220, height: 12, radius: 6)
            SkeletonBlock(width: 196, height: 20, radius: 10)
        }
    }

    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                HStack(spacing: AppSpacing.xLarge) {
                    cardFieldSkeleton(width: 74)
                    cardFieldSkeleton(width: 58)
                }

                SkeletonBlock(width: 120, height: 16, radius: 8)
            }

            Spacer()

            SkeletonBlock(width: 84, height: 24, radius: 8)
        }
    }

    private func cardFieldSkeleton(width: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
            SkeletonBlock(width: width, height: 10, radius: 5)
            SkeletonBlock(width: width + 8, height: 16, radius: 8)
        }
    }
}

#Preview {
    VirtualCardViewSkeleton()
        .padding()
        .appScreenBackground()
}
