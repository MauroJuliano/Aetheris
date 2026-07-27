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
        VStack(spacing: AppSpacing.large) {
            NavBar(
                hasNotifications: false,
                hasBackButton: true,
                model: .init(firstText: viewModel.title, hasInitialSpace: false),
                onBack: onBack
            )

            ZStack {
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
                .opacity(viewModel.isLoading ? 0 : 1)

                RegisterInputSkeleton()
                    .opacity(viewModel.isLoading ? 1 : 0)
            }
        }
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft()
    draft.password = "1234"

    return ConfirmPasswordView(
        viewModel: ConfirmPasswordViewModel(
            service: ResumeService(coreService: MockCoreServiceApi()),
            draft: draft
        ),
        draft: draft,
        onBack: {}
    ) {}
}
