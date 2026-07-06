import AetherisDesignSystem
import SwiftUI

struct BeneficiaryListSkeleton: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Spacer()
                    .frame(height: 50)

                VStack(spacing: 0) {
                    ForEach(0..<4, id: \.self) { index in
                        HStack(spacing: 14) {
                            SkeletonView(.circle)
                                .frame(width: 46, height: 46)

                            VStack(alignment: .leading, spacing: 8) {
                                skeleton(width: nameWidth(for: index), height: 16, radius: 8)
                                skeleton(width: keyWidth(for: index), height: 12, radius: 6)
                            }

                            Spacer()

                            SkeletonView(.circle)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)

                        if index < 3 {
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
            .background(Color.backgroundColorA)
        }
        .background(Color.backgroundColorA)
    }

    private func nameWidth(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return 78
        case 1:
            return 104
        case 2:
            return 64
        default:
            return 118
        }
    }

    private func keyWidth(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return 210
        case 1:
            return 92
        case 2:
            return 128
        default:
            return 76
        }
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

#Preview {
    BeneficiaryListSkeleton()
        .padding(.horizontal)
}
