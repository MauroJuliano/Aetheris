import AetherisDesignSystem
import SwiftUI

struct NotificationsCentreSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                navBar
                notificationSection(titleWidth: 56, rows: 3)
                notificationSection(titleWidth: 88, rows: 2)
                notificationSection(titleWidth: 72, rows: 1)
            }
        }
        .background(Color.backgroundColorA)
    }

    private var navBar: some View {
        HStack {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            skeleton(width: 230, height: 28, radius: 14)

            Spacer()
        }
        .padding(.horizontal)
    }

    private func notificationSection(titleWidth: CGFloat, rows: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            skeleton(width: titleWidth, height: 18, radius: 9)
                .padding(.horizontal)

            VStack(spacing: 0) {
                ForEach(0..<rows, id: \.self) { index in
                    HStack(spacing: 14) {
                        SkeletonView(.circle)
                            .frame(width: 46, height: 46)

                        VStack(alignment: .leading, spacing: 8) {
                            skeleton(width: index == 2 ? 180 : 220, height: 14, radius: 7)
                            skeleton(width: index == 1 ? 145 : 110, height: 14, radius: 7)
                        }

                        Spacer()

                        HStack(spacing: 8) {
                            SkeletonView(.circle)
                                .frame(width: 8, height: 8)
                            skeleton(width: 58, height: 12, radius: 6)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 18)

                    if index < rows - 1 {
                        Divider()
                            .padding(.leading, 78)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.backgroundColorA)
                    .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray.opacity(0.25), lineWidth: 1)
                    )
            )
        }
        .padding(.horizontal)
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

#Preview {
    NotificationsCentreSkeleton()
}
