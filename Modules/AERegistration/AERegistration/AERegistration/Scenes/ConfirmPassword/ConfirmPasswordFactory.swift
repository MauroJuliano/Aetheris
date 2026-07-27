import Core
import SwiftUI

enum ConfirmPasswordFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        draft: RegistrationDraft,
        onBack: @escaping () -> Void,
        onSuccess: @escaping () -> Void
    ) -> ConfirmPasswordView {
        let viewModel = ConfirmPasswordViewModel(
            service: ResumeService(coreService: coreService),
            draft: draft
        )
        return ConfirmPasswordView(
            viewModel: viewModel,
            draft: draft,
            onBack: onBack,
            onSuccess: onSuccess
        )
    }
}
