import Core
import AERegistrationInterface
import SwiftUI

public struct RegistrationFactory: RegistrationFactoryInterface {
    private let coreService: any HasCoreService
    
    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }
    
    public func make(
        onFinished: @escaping () -> Void,
        onBackToLogin: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            RegisterFlow(
                coreService: coreService,
                onBackToLogin: onBackToLogin,
                onRegisterFinished: {
                    onFinished()
                }
            )
        )
    }
}
