import SwiftUI

enum PasswordFactory {
    @MainActor
    static func make(
        draft: RegistrationDraft,
        onBack: @escaping () -> Void,
        onContinue: @escaping () -> Void
    ) -> PasswordView {
        let viewModel = PasswordViewModel(draft: draft)
        return PasswordView(viewModel: viewModel,
                            draft: draft,
                            onBack: onBack,
                            onContinue: onContinue)
    }
}
