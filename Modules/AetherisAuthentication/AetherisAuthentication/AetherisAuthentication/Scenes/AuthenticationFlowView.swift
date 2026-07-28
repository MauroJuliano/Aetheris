import AetherisAuthenticationInterface
import SwiftUI

struct AuthenticationFlowView: View {
    private let dependencies: AuthenticationDependencies
    @EnvironmentObject private var sessionStore: AppSessionStore
    
    init(dependencies: AuthenticationDependencies) {
        self.dependencies = dependencies
    }
    
    @State private var flow: AppFlow = .login

    var body: some View {
        Group {
            if sessionStore.isAuthenticated {
                MainTabContainer(
                    paymentsFactory: dependencies.paymentsFactory
                )
            } else {
                switch flow {
                case .login:
                    Login(
                        onLogin: {
                            sessionStore.isAuthenticated = true
                        },
                        onRegister: {
                            flow = .register
                        }
                    )

                case .register:
                    dependencies.registrationFactory.make(
                        onFinished: {
                            sessionStore.isAuthenticated = true
                        },
                        onBackToLogin: {
                            flow = .login
                        }
                    )
                }
            }
        }
        .onChange(of: sessionStore.isAuthenticated) { _, isAuthenticated in
            if !isAuthenticated {
                flow = .login
            }
        }
    }
}
