import SwiftUI

enum ResumeFactory {
    @MainActor
    static func make(draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> ResumeView {
        let viewModel = ResumeViewModel(draft: draft)
        return ResumeView(viewModel: viewModel,
                          onBack: onBack,
                          onContinue: onContinue)
    }
}
