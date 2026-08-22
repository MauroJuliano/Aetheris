import Core
import SwiftUI

enum EmailFactory {
    @MainActor
    static func make(
        draft: RegistrationDraft,
        onBack: @escaping () -> Void,
        onContinue: @escaping () -> Void
    ) -> EmailView {
        let viewModel = EmailViewModel(draft: draft)
        return EmailView(
            viewModel: viewModel,
            onBack: onBack,
            onContinue: onContinue
        )
    }
}
