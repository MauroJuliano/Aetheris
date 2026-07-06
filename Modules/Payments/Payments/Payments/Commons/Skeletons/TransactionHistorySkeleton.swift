import AetherisDesignSystem
import SwiftUI

struct TransactionHistorySkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                navBar
                transactionSection(titleWidth: 56, rows: 2)
                transactionSection(titleWidth: 88, rows: 1)
                transactionSection(titleWidth: 78, rows: 2)
            }
        }
        .background(Color.backgroundColorA)
    }

    private var navBar: some View {
        HStack {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            skeleton(width: 220, height: 28, radius: 14)

            Spacer()
        }
        .padding(.horizontal)
    }

    private func transactionSection(titleWidth: CGFloat, rows: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            skeleton(width: titleWidth, height: 18, radius: 9)
                .padding(.horizontal)

            VStack(spacing: 0) {
                ForEach(0..<rows, id: \.self) { index in
                    HStack(spacing: 14) {
                        SkeletonView(.circle)
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading, spacing: 8) {
                            skeleton(width: index == 0 ? 145 : 120, height: 16, radius: 8)
                            skeleton(width: index == 0 ? 210 : 165, height: 14, radius: 7)
                        }

                        Spacer()

                        skeleton(width: 64, height: 18, radius: 9)
                    }
                    .padding()

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
    TransactionHistorySkeleton()
}
