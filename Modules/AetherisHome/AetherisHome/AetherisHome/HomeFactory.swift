import AetherisHomeInterface
import AetherisAuthenticationInterface
import Core
import SwiftUI

public final class HomeFactory: HomeFactoryInterface {
    private let coreService: any HasCoreService
    private let identityValidation: any IdentityValidating

    public init(
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating
    ) {
        self.coreService = coreService
        self.identityValidation = identityValidation
    }

    @MainActor public func make() -> AnyView {
        AnyView(HomeFlowCoordinator(
            coreService: coreService,
            identityValidation: identityValidation
        ))
    }
}
