import AetherisDesignSystem
import SwiftUI

struct RegisterInputSkeleton: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 14) {
                skeleton(width: 260, height: 40, radius: 20)
                    .padding(.top, 60)

                VStack(alignment: .leading, spacing: 8) {
                    skeleton(width: 320, height: 18, radius: 9)
                    skeleton(width: 230, height: 18, radius: 9)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 35)

            Spacer()

            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    skeleton(height: 24, radius: 12)

                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 1)
                }
                .padding(.horizontal, 35)

                skeleton(width: 250, height: 50, radius: 25)
            }
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColorA)
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

#Preview {
    RegisterInputSkeleton()
}
