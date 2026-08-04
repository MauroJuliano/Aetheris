import AetherisAuthenticationInterface
import Core
import SwiftUI

public final class IdentityValidationFactory: IdentityValidating {
    private let coreService: any HasCoreService

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    public func authenticate(
        content: IdentityValidationContent,
        onCancel: @escaping () -> Void,
        onResult: @escaping (IdentityValidationResult) -> Void
    ) -> AnyView {
        AnyView(
            IdentityValidationView(
                viewModel: IdentityValidationViewModel(
                    content: content,
                    service: IdentityValidationService(coreService: self.coreService)
                ),
                onCancel: onCancel,
                onResult: onResult
            )
        )
    }
}
