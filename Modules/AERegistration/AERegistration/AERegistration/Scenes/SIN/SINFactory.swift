import Core
import SwiftUI

enum SINFactory {
    @MainActor static func make(coreService: any HasCoreService,
                                draft: RegistrationDraft,
                                onContinue: @escaping () -> Void) -> some View {
        let service: SINServiceProtocol = SINService(coreService: coreService)
        let viewModel = SINViewModel(service: service, draft: draft)
        return SINView(viewModel: viewModel, draft: draft, onContinue: onContinue)
    }
}
