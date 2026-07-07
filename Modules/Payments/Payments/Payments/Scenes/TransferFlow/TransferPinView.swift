import AetherisDesignSystem
import SwiftUI

struct TransferPinView: View {
    @StateObject var viewModel: TransferPinViewModel
    let onBack: () -> Void
    let onValidPin: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            header

            Spacer()

            VStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                lockIcon

                VStack(spacing: AppSpacing.xxSmall) {
                    Text(viewModel.title)
                        .font(AppTypography.heroTitle)
                        .foregroundStyle(Color.textPrimary)

                    Text(viewModel.subtitle)
                        .font(AppTypography.button)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                pinDots

                if viewModel.isError {
                    VStack(spacing: AppSpacing.xxxSmall) {
                        Text("Incorrect PIN. Try again.")
                            .font(AppTypography.callout.weight(.semibold))
                            .foregroundStyle(Color.error)

                        Text("You have \(viewModel.attemptsLeft) attempts left.")
                            .font(AppTypography.cellCaption)
                            .foregroundStyle(Color.textSecondaryColor)
                    }
                }

                Button {
                    // Face ID mock
                } label: {
                    Label("Use Face ID", systemImage: "faceid")
                        .font(AppTypography.onboardingBody.weight(.semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
                .padding(.top, AppSpacing.xxxSmall)
                .disabled(viewModel.isLockedOut)
            }

            Spacer()

            numericKeyboard
                .padding(.bottom, AppSpacing.large + AppSpacing.xxSmall)
        }
        .padding(.horizontal)
        .appScreenBackground()
    }

    private var header: some View {
        HStack(spacing: AppSpacing.large - AppSpacing.xxxSmall) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                    .frame(width: 44, height: 44)
                    .background(Color.surface)
                    .clipShape(Circle())
                    .appShadow(AppShadow.card)
            }

            Text("Confirm Transfer")
                .font(AppTypography.navTitle)
                .foregroundStyle(Color.brandPrimaryColor)

            Spacer()
        }
        .padding(.top, AppSpacing.medium)
    }

    private var lockIcon: some View {
        ZStack {
            Circle()
                .fill(viewModel.lockBackgroundColor)
                .frame(width: 96, height: 96)

            Image(systemName: "lock.fill")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(viewModel.lockColor)
        }
    }

    private var pinDots: some View {
        HStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
            ForEach(0..<viewModel.pinLimit, id: \.self) { index in
                Circle()
                    .fill(index < viewModel.pin.count ? viewModel.dotColor : Color.clear)
                    .frame(width: 28, height: 28)
                    .overlay {
                        Circle()
                            .stroke(
                                index < viewModel.pin.count ? viewModel.dotColor : Color.border,
                                lineWidth: 1.5
                            )
                    }
            }
        }
        .padding(.top, AppSpacing.xSmall + AppSpacing.xxxSmall)
    }

    private var numericKeyboard: some View {
        VStack(spacing: AppSpacing.xLarge - AppSpacing.xxxSmall) {
            ForEach(keyboardRows, id: \.self) { row in
                HStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                    ForEach(row, id: \.self) { item in
                        keypadButton(item)
                    }
                }
            }
        }
    }

    private var keyboardRows: [[String]] {
        [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["", "0", "delete"]
        ]
    }

    @ViewBuilder
    private func keypadButton(_ value: String) -> some View {
        if value.isEmpty {
            Color.clear
                .frame(width: 72, height: 72)
        } else if value == "delete" {
            Button {
                viewModel.deleteDigit()
            } label: {
                Image(systemName: "delete.left")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color.textPrimary)
                    .frame(width: 72, height: 72)
            }
        } else {
            Button {
                viewModel.handleDigit(value, onValidPin: onValidPin)
            } label: {
                VStack(spacing: AppSpacing.xxxSmall) {
                    Text(value)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(Color.textPrimary)

                    Text(viewModel.letters(for: value))
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(Color.textSecondaryColor)
                }
                .frame(width: 72, height: 72)
                .background(Color.surface)
                .clipShape(Circle())
                .appShadow(AppShadow.soft)
            }
            .disabled(viewModel.isLockedOut)
        }
    }
}

#Preview {
    TransferPinView(
        viewModel: TransferPinViewModel(receipt: .mock),
        onBack: {},
        onValidPin: {}
    )
}
