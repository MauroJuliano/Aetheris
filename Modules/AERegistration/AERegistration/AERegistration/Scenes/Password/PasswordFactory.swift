import SwiftUI

enum PasswordFactory {
    @MainActor
    static func make(
        draft: RegistrationDraft,
        onContinue: @escaping () -> Void
    ) -> PasswordView {
        let viewModel = PasswordViewModel(draft: draft)
        return PasswordView(viewModel: viewModel, draft: draft, onContinue: onContinue)
    }
}
