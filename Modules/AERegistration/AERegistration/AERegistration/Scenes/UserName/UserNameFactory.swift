import Core
import SwiftUI

enum UserNameFactory {
    @MainActor
    static func make(draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> some View {
        let viewModel = UserNameViewModel(draft: draft)
        return UserNameView(viewModel: viewModel,
                            draft: draft,
                            onBack: onBack,
                            onContinue: onContinue)
    }
}
