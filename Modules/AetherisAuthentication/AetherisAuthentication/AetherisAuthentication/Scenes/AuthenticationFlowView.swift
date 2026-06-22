import AetherisAuthenticationInterface
import SwiftUI

struct AuthenticationFlowView: View {
    private let dependencies: AuthenticationDependencies
    
    init(dependencies: AuthenticationDependencies) {
        self.dependencies = dependencies
    }
    
    @State private var flow: AppFlow = .login

    var body: some View {
        switch flow {
        case .login:
            Login(
                onLogin: {
                    flow = .main
                },
                onRegister: {
                    flow = .register
                }
            )

        case .register:
            dependencies.registrationFactory.make {
                flow = .login
            }

        case .main:
            MainTabContainer(
                paymentsFactory: dependencies.paymentsFactory
            )
        }
    }
}
