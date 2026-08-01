import Core
import SwiftUI

enum MothersNameInputFactory {
    @MainActor
    static func make(draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> MothersNameInputView {
        let viewModel = MothersNameInputViewModel(draft: draft)
        return MothersNameInputView(viewModel: viewModel,
                                    draft: draft,
                                    onBack: onBack,
                                    onContinue: onContinue)
    }
}
