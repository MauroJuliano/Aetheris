import AERegistrationInterface
import SwiftUI

public struct RegistrationFactory: RegistrationFactoryInterface {
    
    public init() {}
    
    public func make(onFinished: @escaping () -> Void) -> AnyView {
        AnyView(
            RegisterFlow(onRegisterFinished: {
                onFinished()
            })
        )
    }
}
