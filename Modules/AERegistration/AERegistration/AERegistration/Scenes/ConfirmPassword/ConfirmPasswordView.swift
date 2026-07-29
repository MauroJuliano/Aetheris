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
        ZStack {
            if viewModel.isLoading {
                RegisterInputSkeleton()
            } else {
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
                    secureTextVisibleLabel: Strings.Password.hide
                ) {
                    viewModel.submit(onSuccess: onSuccess)
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            if !viewModel.isLoading {
                NavBar(
                    hasNotifications: false,
                    hasBackButton: true,
                    model: .init(hasInitialSpace: false),
                    onBack: onBack
                )
                .padding(.top, AppSpacing.medium)
            }
        }
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}
