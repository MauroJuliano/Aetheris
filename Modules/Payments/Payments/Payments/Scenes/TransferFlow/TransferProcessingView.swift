import AetherisDesignSystem
import SwiftUI

struct TransferProcessingView: View {
    @StateObject var viewModel: TransferProcessingViewModel
    let onCompleted: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.large + AppSpacing.xxxSmall) {
            Spacer()

            processingIcon

            VStack(spacing: AppSpacing.xSmall + AppSpacing.xxxSmall) {
                Text(Strings.TransferProcessing.title)
                    .font(AppTypography.heroTitle)
                    .foregroundStyle(Color.textPrimary)

                Text(Strings.TransferProcessing.subtitle)
                    .font(AppTypography.onboardingBody)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, AppSpacing.xLarge)
        .appScreenBackground()
        .onAppear {
            viewModel.start(onCompleted: onCompleted)
        }
    }

    private var processingIcon: some View {
        ZStack {
            Circle()
                .stroke(Color.brandPrimaryColor.opacity(0.12), lineWidth: 8)
                .frame(width: 170, height: 170)

            Circle()
                .trim(from: 0.08, to: 0.78)
                .stroke(
                    Color.brandPrimaryColor,
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 170, height: 170)
                .rotationEffect(.degrees(viewModel.isAnimating ? 360 : 0))
                .animation(
                    .linear(duration: 1.4).repeatForever(autoreverses: false),
                    value: viewModel.isAnimating
                )

            Image(systemName: "paperplane.fill")
                .font(.system(size: 48, weight: .semibold))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }
}

#Preview {
    TransferProcessingView(
        viewModel: TransferProcessingViewModel(receipt: .mock),
        onCompleted: {}
    )
}
