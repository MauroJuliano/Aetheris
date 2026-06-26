import SwiftUI
import AERegistrationInterface
import PaymentsInterface
import AetherisAuthenticationInterface

public final class AuthenticationFactory: AuthenticationFactoryInterface {
    private let dependencies: AuthenticationDependencies
    
    public init(dependencies: AuthenticationDependencies) {
        self.dependencies = dependencies
    }

    public func make() -> AnyView {
        AnyView(
            AuthenticationFlowView(
                dependencies: dependencies
            )
        )
    }
}
