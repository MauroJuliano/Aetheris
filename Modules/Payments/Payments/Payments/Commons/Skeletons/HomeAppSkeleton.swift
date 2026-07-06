import AetherisDesignSystem
import SwiftUI

struct HomeAppSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                navBar
                cards
                recipients
                quickActions
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: 100)
        }
        .appScreenBackground()
    }

    private var navBar: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                skeleton(width: 120, height: 22, radius: 11)
                skeleton(width: 150, height: 34, radius: 17)
            }

            Spacer()

            SkeletonView(.circle)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal)
    }

    private var cards: some View {
        ZStack {
            skeleton(height: 200, radius: 24)
                .padding(.horizontal, 20)
                .offset(x: 10, y: -8)
                .rotationEffect(.degrees(3))
                .opacity(0.55)

            skeleton(height: 200, radius: 24)
                .padding(.horizontal, 8)
        }
        .frame(height: 230)
    }

    private var recipients: some View {
        section {
            HStack {
                skeleton(width: 90, height: 20, radius: 10)
                Spacer()
                skeleton(width: 52, height: 18, radius: 9)
            }

            HStack(spacing: 16) {
                ForEach(0..<5, id: \.self) { _ in
                    VStack(spacing: 8) {
                        SkeletonView(.circle)
                            .frame(width: 58, height: 58)
                        skeleton(height: 12, radius: 6)
                        skeleton(width: 42, height: 12, radius: 6)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private var quickActions: some View {
        section {
            skeleton(width: 190, height: 20, radius: 10)

            HStack(spacing: 16) {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 18) {
                        skeleton(width: 38, height: 38, radius: 12)

                        Spacer(minLength: 8)

                        VStack(alignment: .leading, spacing: 8) {
                            skeleton(height: 14, radius: 7)
                            skeleton(width: 58, height: 12, radius: 6)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 132)
                    .background(
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .fill(Color.surface)
                    )
                }
            }
        }
    }

    private var chart: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            ZStack(alignment: .bottom) {
                ForEach(0..<5, id: \.self) { index in
                    skeleton(height: 1, radius: 0)
                        .opacity(0.45)
                        .offset(y: CGFloat(index) * -24)
                }

                Path { path in
                    path.move(to: CGPoint(x: width * 0.02, y: 84))
                    path.addCurve(
                        to: CGPoint(x: width * 0.36, y: 52),
                        control1: CGPoint(x: width * 0.12, y: 62),
                        control2: CGPoint(x: width * 0.24, y: 94)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.68, y: 44),
                        control1: CGPoint(x: width * 0.47, y: 20),
                        control2: CGPoint(x: width * 0.58, y: 72)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.98, y: 28),
                        control1: CGPoint(x: width * 0.78, y: 18),
                        control2: CGPoint(x: width * 0.88, y: 46)
                    )
                }
                .stroke(Color.gray.opacity(0.35), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .blur(radius: 0.4)
            }
        }
    }

    private func section<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            content()
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

#Preview {
    HomeAppSkeleton()
}
