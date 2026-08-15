import Core
import SwiftUI

enum BirthdateFactory {
    @MainActor
    static func make(draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> BirthdateView {
        let viewModel = BirthdateViewModel(draft: draft)
        return BirthdateView(viewModel: viewModel,
                             onBack: onBack,
                             onContinue: onContinue)
    }
}
