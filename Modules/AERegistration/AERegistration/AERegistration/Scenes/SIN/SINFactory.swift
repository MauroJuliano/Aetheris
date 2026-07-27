import Core
import SwiftUI

enum SINFactory {
    @MainActor static func make(coreService: any HasCoreService,
                                draft: RegistrationDraft,
                                onBack: @escaping () -> Void,
                                onContinue: @escaping () -> Void) -> some View {
        let service: SINServiceProtocol = SINService(coreService: coreService)
        let viewModel = SINViewModel(service: service, draft: draft)
        return SINView(viewModel: viewModel,
                       draft: draft,
                       onBack: onBack,
                       onContinue: onContinue)
    }
}
