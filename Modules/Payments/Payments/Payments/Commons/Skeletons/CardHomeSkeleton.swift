import AetherisDesignSystem
import SwiftUI

struct CardHomeSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                navBar
                cards
                quickActions
                financialSummary
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: 100)
        }
        .background(Color.backgroundColorA)
    }

    private var navBar: some View {
        HStack {
            skeleton(width: 92, height: 34, radius: 17)

            Spacer()

            SkeletonView(.circle)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal)
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
            HStack(spacing: 24) {
                ForEach(0..<4, id: \.self) { _ in
                    VStack(spacing: 10) {
                        SkeletonView(.circle)
                            .frame(width: 54, height: 54)
                        skeleton(width: 52, height: 12, radius: 6)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private var financialSummary: some View {
        section(spacing: 0) {
            ForEach(0..<4, id: \.self) { index in
                HStack(spacing: 12) {
                    SkeletonView(.circle)
                        .frame(width: 40, height: 40)

                    VStack(alignment: .leading, spacing: 8) {
                        skeleton(width: index == 3 ? 130 : 110, height: 16, radius: 8)
                        skeleton(width: index == 3 ? 190 : 135, height: 14, radius: 7)
                    }

                    Spacer()

                    skeleton(width: 62, height: 18, radius: 9)
                }
                .padding()

                if index < 3 {
                    Divider()
                }
            }
        }
    }

    private func section<Content: View>(
        spacing: CGFloat = 18,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            content()
        }
        .padding(spacing == 0 ? 0 : 16)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 12, y: 12)
        )
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

#Preview {
    CardHomeSkeleton()
}
