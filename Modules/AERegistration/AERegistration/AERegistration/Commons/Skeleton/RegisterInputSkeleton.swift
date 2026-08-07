import AetherisDesignSystem
import SwiftUI

struct RegisterInputSkeleton: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
                skeleton(width: 260, height: 40, radius: AppRadius.large)
                    .padding(.top, 60)

                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    skeleton(width: 320, height: 18, radius: 9)
                    skeleton(width: 230, height: 18, radius: 9)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, AppSpacing.formHorizontal)

            Spacer()

            VStack(spacing: AppSpacing.xxLarge) {
                VStack(spacing: AppSpacing.xSmall) {
                    skeleton(height: 24, radius: 12)

                    Rectangle()
                        .fill(Color.border)
                        .frame(height: 1)
                }
                .padding(.horizontal, AppSpacing.formHorizontal)

                skeleton(width: 250, height: 50, radius: AppRadius.pill)
            }
            .padding(.bottom, AppSpacing.xxLarge)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appScreenBackground()
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
