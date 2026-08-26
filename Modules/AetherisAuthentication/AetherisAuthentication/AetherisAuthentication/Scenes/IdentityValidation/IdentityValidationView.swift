import AetherisAuthenticationInterface
import AetherisDesignSystem
import Core
import SwiftUI

struct IdentityValidationView: View {
    @StateObject var viewModel: IdentityValidationViewModel
    let onCancel: () -> Void
    let onResult: (IdentityValidationResult) -> Void
    @State private var showValidationError = false
    @State private var didReportFailure = false

    var body: some View {
        VStack(spacing: 0) {
            header
            Spacer()
            challenge
            Spacer()
            numericKeyboard
                .padding(.bottom, AppSpacing.large + AppSpacing.xxSmall)
        }
        .padding(.horizontal)
        .appScreenBackground()
        .onChange(of: viewModel.validationErrorMessage) { _, message in
            showValidationError = message != nil
            if message != nil {
                didReportFailure = false
            }
        }
        .sheet(isPresented: $showValidationError, onDismiss: finishFailureIfNeeded) {
            ActionErrorSheet(
                title: Strings.IdentityValidation.errorTitle,
                description: viewModel.validationErrorMessage ?? Strings.IdentityValidation.errorDescription,
                primaryButtonTitle: Strings.IdentityValidation.close,
                onPrimaryAction: {
                    showValidationError = false
                    DispatchQueue.main.async {
                        finishFailureIfNeeded()
                    }
                }
            )
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("identity.validation.screen")
    }

    private var header: some View {
        HStack(spacing: AppSpacing.large - AppSpacing.xxxSmall) {
            Button(action: onCancel) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                    .frame(width: 44, height: 44)
                    .background(Color.surface)
                    .clipShape(Circle())
                    .appShadow(AppShadow.card)
            }
            Text(viewModel.content.navigationTitle)
                .font(AppTypography.navTitle)
                .foregroundStyle(Color.brandPrimaryColor)
            Spacer()
        }
        .padding(.top, AppSpacing.medium)
    }

    private var challenge: some View {
        VStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
            ZStack {
                Circle()
                    .fill(viewModel.lockBackgroundColor)
                    .frame(width: 96, height: 96)
                Image(systemName: "lock.fill")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(viewModel.lockColor)
            }
            VStack(spacing: AppSpacing.xxSmall) {
                Text(viewModel.content.title)
                    .font(AppTypography.heroTitle)
                    .foregroundStyle(Color.textPrimary)
                Text(viewModel.content.description)
                    .font(AppTypography.button)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            HStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                ForEach(0..<viewModel.pinLimit, id: \.self) { index in
                    Circle()
                        .fill(index < viewModel.pin.count ? viewModel.dotColor : Color.clear)
                        .frame(width: 28, height: 28)
                        .overlay {
                            Circle().stroke(
                                index < viewModel.pin.count ? viewModel.dotColor : Color.border,
                                lineWidth: 1.5
                            )
                        }
                }
            }
            if viewModel.isAuthenticating {
                ProgressView()
                    .tint(Color.brandPrimaryColor)
                    .accessibilityIdentifier("identity.validation.loading")
            }
        }
    }

    private var numericKeyboard: some View {
        VStack(spacing: AppSpacing.xLarge - AppSpacing.xxxSmall) {
            ForEach(keyboardRows, id: \.self) { row in
                HStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                    ForEach(row, id: \.self) { keypadButton($0) }
                }
            }
        }
    }

    private var keyboardRows: [[String]] {
        [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"], ["", "0", "delete"]]
    }

    @ViewBuilder
    private func keypadButton(_ value: String) -> some View {
        if value.isEmpty {
            Color.clear.frame(width: 72, height: 72)
        } else if value == "delete" {
            Button(action: viewModel.deleteDigit) {
                Image(systemName: "delete.left")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color.textPrimary)
                    .frame(width: 72, height: 72)
            }
        } else {
            Button {
                viewModel.handleDigit(value) { onResult(.authorized($0)) }
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

    private func finishFailureIfNeeded() {
        guard !didReportFailure else { return }
        guard viewModel.validationErrorMessage != nil else { return }
        didReportFailure = true
        viewModel.clearError()
        onResult(.failed)
    }
}

#Preview {
    IdentityValidationView(
        viewModel: IdentityValidationViewModel(
            content: IdentityValidationContent(
                navigationTitle: "Security check",
                title: "Enter your PIN",
                description: "Confirm your identity to continue."
            ),
            service: IdentityValidationService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onCancel: {},
        onResult: { _ in }
    )
}
