import Core
import SwiftUI

enum BirthdateFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> BirthdateView {
        let viewModel = BirthdateViewModel(service: BirthdateService(coreService: coreService),
                                           draft: draft)
        return BirthdateView(viewModel: viewModel,
                             draft: draft,
                             onBack: onBack,
                             onContinue: onContinue)
    }
}
