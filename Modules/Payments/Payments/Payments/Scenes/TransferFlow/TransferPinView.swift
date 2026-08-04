import AetherisDesignSystem
import SwiftUI

struct TransferPinView: View {
    @StateObject var viewModel: TransferPinViewModel
    let onBack: () -> Void
    let onAuthorized: (IdentityAuthorization) -> Void
    let onValidationFailed: () -> Void
    @State private var showValidationError = false

    var body: some View {
        VStack(spacing: 0) {
            header

            Spacer()

            VStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                lockIcon

                VStack(spacing: AppSpacing.xxSmall) {
                    Text(Strings.TransferPin.title)
                        .font(AppTypography.heroTitle)
                        .foregroundStyle(Color.textPrimary)

                    Text(Strings.TransferPin.subtitle(
                        viewModel.draft.formattedAmount,
                        viewModel.draft.beneficiaryName
                    ))
                        .font(AppTypography.button)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                pinDots

                if viewModel.isAuthenticating {
                    ProgressView()
                        .tint(Color.brandPrimaryColor)
                        .accessibilityIdentifier("transfer.pinLoading")
                }
            }

            Spacer()

            numericKeyboard
                .padding(.bottom, AppSpacing.large + AppSpacing.xxSmall)
        }
        .padding(.horizontal)
        .appScreenBackground()
        .onChange(of: viewModel.validationErrorMessage) { _, newValue in
            showValidationError = newValue != nil
        }
        .sheet(isPresented: $showValidationError, onDismiss: {
            guard viewModel.validationErrorMessage != nil else { return }
            viewModel.clearError()
            onValidationFailed()
        }) {
            ActionErrorSheet(
                title: Strings.TransferPin.validationErrorTitle,
                description: viewModel.validationErrorMessage ?? Strings.TransferPin.validationErrorDescription,
                primaryButtonTitle: Strings.Common.close,
                secondaryButtonTitle: nil,
                onPrimaryAction: {
                    showValidationError = false
                },
                onSecondaryAction: nil
            )
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("transfer.pinErrorSheet")
        }
        .accessibilityIdentifier("transfer.pinScreen")
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

            Text(Strings.TransferPin.confirmTransfer)
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
                viewModel.handleDigit(value, onAuthorized: onAuthorized)
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
            .disabled(viewModel.isAuthenticating)
            .accessibilityIdentifier("pin.key.\(value)")
        }
    }
}
