import AetherisDesignSystem
import SwiftUI

struct PasswordView: View {
    @StateObject private var viewModel: PasswordViewModel
    @ObservedObject private var draft: RegistrationDraft
    private let onContinue: () -> Void

    init(
        viewModel: PasswordViewModel,
        draft: RegistrationDraft,
        onContinue: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _draft = ObservedObject(wrappedValue: draft)
        self.onContinue = onContinue
    }

    var body: some View {
        RegisterView(
            title: viewModel.title,
            subTitle: viewModel.subTitle,
            textFieldValue: Binding(
                get: { draft.password },
                set: { viewModel.updatePassword($0) }
            ),
            buttonTitle: viewModel.buttonName,
            textFieldPlaceholder: viewModel.placeholder,
            keyboardType: .numberPad,
            isSecureEntry: true,
            fieldErrorMessage: viewModel.errorMessage,
            secureTextHiddenLabel: Strings.Password.show,
            secureTextVisibleLabel: Strings.Password.hide
        ) {
            viewModel.continueTapped(onContinue: onContinue)
        }
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft()
    PasswordView(
        viewModel: PasswordViewModel(draft: draft),
        draft: draft
    ) {}
}
