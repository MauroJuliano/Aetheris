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
            dependencies.registrationFactory.make(
                onFinished: {
                    flow = .main
                },
                onBackToLogin: {
                    flow = .login
                }
            )

        case .main:
            MainTabContainer(
                paymentsFactory: dependencies.paymentsFactory
            )
        }
    }
}
