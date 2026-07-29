import AetherisAuthenticationInterface
import SwiftUI

struct AuthenticationFlowView: View {
    private let dependencies: AuthenticationDependencies
    @EnvironmentObject private var sessionStore: AppSessionStore
    
    init(dependencies: AuthenticationDependencies) {
        self.dependencies = dependencies
    }
    
    @State private var flow: AppFlow = .login
    @State private var authPath: [AuthRoute] = []

    var body: some View {
        Group {
            if sessionStore.isAuthenticated {
                MainTabContainer(
                    paymentsFactory: dependencies.paymentsFactory
                )
            } else {
                switch flow {
                case .login:
                    NavigationStack(path: $authPath) {
                        Login(
                            onLogin: {
                                sessionStore.isAuthenticated = true
                            },
                            onRegister: {
                                flow = .register
                            },
                            onForgotPassword: { email in
                                authPath.append(.forgotPassword(email: email))
                            }
                        )
                        .navigationDestination(for: AuthRoute.self) { route in
                            switch route {
                            case let .forgotPassword(email):
                                ForgotPasswordView(
                                    email: email,
                                    onBack: {
                                        if !authPath.isEmpty {
                                            authPath.removeLast()
                                        }
                                    },
                                    onSendResetLink: { _ in },
                                    onBackToLogin: {
                                        authPath.removeAll()
                                    }
                                )
                            }
                        }
                    }

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
                authPath.removeAll()
            }
        }
    }
}
