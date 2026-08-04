import Core
import SwiftUI

enum TransferPinFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        draft: TransferDraft,
        onBack: @escaping () -> Void,
        onAuthorized: @escaping (IdentityAuthorization) -> Void,
        onValidationFailed: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            TransferPinView(
                viewModel: TransferPinViewModel(
                    draft: draft,
                    service: SendMoneyService(coreService: coreService)
                ),
                onBack: onBack,
                onAuthorized: onAuthorized,
                onValidationFailed: onValidationFailed
            )
        )
    }
}
