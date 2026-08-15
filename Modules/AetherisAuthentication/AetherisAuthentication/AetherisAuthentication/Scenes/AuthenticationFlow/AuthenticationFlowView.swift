import AetherisAuthenticationInterface
import AccountInterface
import AERegistrationInterface
import AetherisCardsInterface
import AetherisHomeInterface
import AetherisTransfersInterface
import Core
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
                    homeFactory: dependencies.homeFactory,
                    cardsFactory: dependencies.cardsFactory,
                    transfersFactory: dependencies.transfersFactory,
                    accountFactory: dependencies.accountFactory
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

#Preview {
    AuthenticationFlowView(
        dependencies: AuthenticationPreviewDependencies()
    )
    .environmentObject(AppSessionStore())
}

final class AuthenticationPreviewDependencies:
    HasRegistration,
    HasHome,
    HasCards,
    HasTransfers,
    HasAccount {
    let registrationFactory: RegistrationFactoryInterface = AuthenticationPreviewRegistrationFactory()
    let homeFactory: HomeFactoryInterface = AuthenticationPreviewHomeFactory()
    let cardsFactory: CardsFactoryInterface = AuthenticationPreviewCardsFactory()
    let transfersFactory: TransfersFactoryInterface = AuthenticationPreviewTransfersFactory()
    let accountFactory: AccountFactoryInterface = AuthenticationPreviewAccountFactory()
}

struct AuthenticationPreviewRegistrationFactory: RegistrationFactoryInterface {
    init(coreService: any HasCoreService) {}
    init() {}

    func make(
        onFinished: @escaping () -> Void,
        onBackToLogin: @escaping () -> Void
    ) -> AnyView {
        AnyView(Text("Registration preview"))
    }
}

struct AuthenticationPreviewHomeFactory: HomeFactoryInterface {
    func make() -> AnyView {
        AnyView(Text("Home preview"))
    }
}

struct AuthenticationPreviewCardsFactory: CardsFactoryInterface {
    func make(onFinished: @escaping () -> Void) -> AnyView {
        AnyView(Text("Cards preview"))
    }
}

struct AuthenticationPreviewTransfersFactory: TransfersFactoryInterface {
    func make(onFinished: @escaping () -> Void) -> AnyView {
        AnyView(Text("Transfers preview"))
    }
}

struct AuthenticationPreviewAccountFactory: AccountFactoryInterface {
    func make(
        entryPoint: AccountEntryPoint,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(Text("Account preview"))
    }
}
