import SwiftUI

enum ResumeFactory {
    @MainActor
    static func make(draft: RegistrationDraft,
                     onContinue: @escaping () -> Void) -> ResumeView {
        let viewModel = ResumeViewModel(draft: draft)
        return ResumeView(viewModel: viewModel, onContinue: onContinue)
    }
}
