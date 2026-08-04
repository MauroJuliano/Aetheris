import AetherisDesignSystem
import SwiftUI

struct TransferProcessingView: View {
    @StateObject var viewModel: TransferProcessingViewModel
    @State private var isAnimating = false
    let onCompleted: (TransferReceiptModel) -> Void
    let onTryLater: () -> Void

    var body: some View {
        Group {
            switch viewModel.state {
            case .submitting:
                processingContent
            case let .failed(message):
                FeedbackView(
                    title: Strings.TransferProcessing.errorTitle,
                    description: message,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    secondaryButtonTitle: Strings.HomeApp.tryLater,
                    onPrimaryAction: {
                        Task { await viewModel.submit(onCompleted: onCompleted) }
                    },
                    onSecondaryAction: onTryLater
                )
                .accessibilityIdentifier("transfer.processingError")
            }
        }
        .task { await viewModel.submit(onCompleted: onCompleted) }
        .onAppear { isAnimating = true }
    }

    private var processingContent: some View {
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
        .accessibilityIdentifier("transfer.processingScreen")
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
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(.linear(duration: 1.4).repeatForever(autoreverses: false), value: isAnimating)

            Image(systemName: "paperplane.fill")
                .font(.system(size: 48, weight: .semibold))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }
}
