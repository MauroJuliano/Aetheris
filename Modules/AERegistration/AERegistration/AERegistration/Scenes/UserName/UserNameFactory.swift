import Core
import SwiftUI

enum UserNameFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     draft: RegistrationDraft,
                     onBack: @escaping () -> Void,
                     onContinue: @escaping () -> Void) -> some View {
        let service = UserNameService(coreService: coreService)
        let viewModel = UserNameViewModel(service: service, draft: draft)
        return UserNameView(viewModel: viewModel,
                            draft: draft,
                            onBack: onBack,
                            onContinue: onContinue)
    }
}
