import AetherisDesignSystem
import SwiftUI

struct CardHomeSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
                navBar
                cards
                quickActions
                financialSummary
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.top, AppSpacing.xSmall)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: AppSpacing.bottomBarClearance)
        }
        .appScreenBackground()
    }

    private var navBar: some View {
        HStack {
            skeleton(width: 92, height: 34, radius: 17)

            Spacer()

            SkeletonView(.circle)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private var cards: some View {
        ZStack {
            skeleton(height: 200, radius: 24)
                .padding(.horizontal, 22)
                .offset(x: 10, y: -8)
                .rotationEffect(.degrees(3))
                .opacity(0.5)

            skeleton(height: 200, radius: 24)
                .padding(.horizontal, 8)
        }
        .frame(height: 230)
    }

    private var quickActions: some View {
        section {
            HStack(spacing: AppSpacing.xLarge) {
                ForEach(0..<4, id: \.self) { _ in
                    VStack(spacing: AppSpacing.xSmall + AppSpacing.xxxSmall) {
                        SkeletonView(.circle)
                            .frame(width: 54, height: 54)
                        skeleton(width: 52, height: 12, radius: 6)
                    }
                    .padding(.vertical, AppSpacing.medium)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private var financialSummary: some View {
        section(spacing: 0) {
            ForEach(0..<4, id: \.self) { index in
                HStack(spacing: AppSpacing.small) {
                    SkeletonView(.circle)
                        .frame(width: 40, height: 40)

                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        skeleton(width: index == 3 ? 130 : 110, height: 16, radius: 8)
                        skeleton(width: index == 3 ? 190 : 135, height: 14, radius: 7)
                    }

                    Spacer()

                    skeleton(width: 62, height: 18, radius: 9)
                }
                .padding(AppSpacing.medium)

                if index < 3 {
                    Divider()
                }
            }
        }
    }

    private func section<Content: View>(
        spacing: CGFloat = AppSpacing.medium + AppSpacing.xxxSmall,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            content()
        }
        .padding(spacing == 0 ? 0 : AppSpacing.medium)
        .appCardSurface()
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

