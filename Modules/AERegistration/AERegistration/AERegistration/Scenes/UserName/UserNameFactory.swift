import Core
import SwiftUI

enum UserNameFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     draft: RegistrationDraft,
                     onContinue: @escaping () -> Void) -> some View {
        let service = UserNameService(coreService: coreService)
        let viewModel = UserNameViewModel(service: service, draft: draft)
        return UserNameView(viewModel: viewModel, draft: draft, onContinue: onContinue)
    }
}
