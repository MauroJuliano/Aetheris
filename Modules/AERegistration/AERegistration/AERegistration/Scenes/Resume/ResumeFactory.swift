import Core
import SwiftUI

enum ResumeFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> ResumeView {
        let viewModel = ResumeViewModel(
            service: RegistrationService(coreService: coreService),
            draft: draft
        )
        return ResumeView(viewModel: viewModel,
                          onBack: onBack,
                          onContinue: onContinue)
    }
}
