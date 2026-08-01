import Core
import SwiftUI

enum SINFactory {
    @MainActor static func make(draft: RegistrationDraft,
                                onBack: @escaping () -> Void,
                                onContinue: @escaping () -> Void) -> some View {
        let viewModel = SINViewModel(draft: draft)
        return SINView(viewModel: viewModel,
                       draft: draft,
                       onBack: onBack,
                       onContinue: onContinue)
    }
}
