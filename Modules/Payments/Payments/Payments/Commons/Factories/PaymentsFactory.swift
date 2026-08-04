import AetherisAuthenticationInterface
import Core
import PaymentsInterface
import SwiftUI

@MainActor
public final class PaymentsFactory: PaymentsFactoryInterface {
    private let coreService: any HasCoreService
    private let identityValidation: any IdentityValidating
    private let profileStore = ProfileStore()

    public init(
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating
    ) {
        self.coreService = coreService
        self.identityValidation = identityValidation
    }
    
    public func make(entryPoint: PaymentsEntryPoint,
                     onFinished: @escaping () -> Void) -> AnyView {
        
        AnyView(PaymentsFlowCoordinator(entryPoint: entryPoint,
                                        coreService: coreService,
                                        identityValidation: identityValidation,
                                        profileStore: profileStore,
                                        onFinished: {
            onFinished()
        }))
    }
}
