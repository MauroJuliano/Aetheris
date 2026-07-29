import Core
import SwiftUI

enum MothersNameInputFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> MothersNameInputView {
        let viewModel = MothersNameInputViewModel(service: MothersNameInputService(coreService: coreService),
                                                  draft: draft)
        return MothersNameInputView(viewModel: viewModel,
                                    draft: draft,
                                    onBack: onBack,
                                    onContinue: onContinue)
    }
}
