import SwiftUI

struct NumericKeyboardSkeleton: View {
    var body: some View {
        VStack(spacing: AppSpacing.xLarge - AppSpacing.xSmall) {
            VStack(spacing: 8) {
                SkeletonBlock(width: 150, height: 30, radius: 12)
                SkeletonBlock(width: 180, height: 14, radius: 7)
                SkeletonBlock(width: 120, height: 14, radius: 7)
            }
            .padding(.bottom, 12)

            VStack(spacing: AppComponentMetrics.keyboardRowSpacing) {
                ForEach(0..<4, id: \.self) { _ in
                    HStack(spacing: AppComponentMetrics.keyboardKeySpacing) {
                        ForEach(0..<3, id: \.self) { _ in
                            SkeletonBlock(
                                width: 72,
                                height: AppComponentMetrics.keyboardKeyHeight,
                                radius: AppComponentMetrics.keyboardKeyCornerRadius
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal, AppComponentMetrics.keyboardContainerHorizontalPadding)
        .padding(.top, AppComponentMetrics.keyboardContainerTopPadding)
        .padding(.bottom, AppComponentMetrics.keyboardContainerBottomPadding)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.large + AppRadius.medium, style: .continuous)
                .fill(Color.backgroundColorA)
                .appShadow(AppShadow.soft)
        )
    }
}

#Preview {
    NumericKeyboardSkeleton()
        .padding()
        .appScreenBackground()
}
