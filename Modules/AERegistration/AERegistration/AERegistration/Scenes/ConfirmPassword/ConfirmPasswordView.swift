import AetherisDesignSystem
import Core
import SwiftUI

struct ConfirmPasswordView: View {
    @StateObject private var viewModel: ConfirmPasswordViewModel
    @ObservedObject private var draft: RegistrationDraft
    private let onBack: () -> Void
    private let onSuccess: () -> Void

    init(
        viewModel: ConfirmPasswordViewModel,
        draft: RegistrationDraft,
        onBack: @escaping () -> Void,
        onSuccess: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _draft = ObservedObject(wrappedValue: draft)
        self.onBack = onBack
        self.onSuccess = onSuccess
    }

    var body: some View {
        RegisterView(
                    title: viewModel.title,
                    subTitle: viewModel.subTitle,
                    textFieldValue: Binding(
                        get: { draft.confirmPassword },
                        set: { viewModel.updateConfirmPassword($0) }
                    ),
                    buttonTitle: viewModel.buttonName,
                    textFieldPlaceholder: viewModel.placeholder,
                    keyboardType: .numberPad,
                    isSecureEntry: true,
                    fieldErrorMessage: viewModel.errorMessage,
                    secureTextHiddenLabel: Strings.Password.show,
                    secureTextVisibleLabel: Strings.Password.hide,
                    isLoading: viewModel.isLoading
        ) {
                    Task {
                        if await viewModel.submit() {
                            onSuccess()
                        }
                    }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            NavBar(
                    hasNotifications: false,
                    hasBackButton: true,
                    model: .init(hasInitialSpace: false),
                    onBack: onBack
                )
                .toSkeleton(enable: viewModel.isLoading)
                .padding(.top, AppSpacing.medium)
        }
        .appScreenBackground()
        .navigationBarHidden(true)
        .sheet(isPresented: submissionErrorBinding) {
            ActionErrorSheet(
                title: Strings.SubmissionError.title,
                description: viewModel.submissionErrorDescription,
                primaryButtonTitle: Strings.SubmissionError.tryAgain,
                secondaryButtonTitle: Strings.SubmissionError.cancel,
                onPrimaryAction: {
                    viewModel.dismissSubmissionError()
                    Task {
                        if await viewModel.submit() {
                            onSuccess()
                        }
                    }
                },
                onSecondaryAction: {
                    viewModel.dismissSubmissionError()
                }
            )
        }
    }

    private var submissionErrorBinding: Binding<Bool> {
        Binding(
            get: { viewModel.submissionError != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.dismissSubmissionError()
                }
            }
        )
    }
}

#Preview {
    let draft = RegistrationDraft.previewFilled

    ConfirmPasswordView(
        viewModel: ConfirmPasswordViewModel(
            service: RegistrationService(
                coreService: DemoCoreService(delay: 0)
            ),
            draft: draft
        ),
        draft: draft,
        onBack: {},
        onSuccess: {}
    )
}
