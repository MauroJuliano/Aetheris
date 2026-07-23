import Core
import SwiftUI

enum BirthdateFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     draft: RegistrationDraft,
                     onContinue: @escaping () -> Void) -> BirthdateView {
        let viewModel = BirthdateViewModel(service: BirthdateService(coreService: coreService),
                                           draft: draft)
        return BirthdateView(viewModel: viewModel, draft: draft, onContinue: onContinue)
    }
}
