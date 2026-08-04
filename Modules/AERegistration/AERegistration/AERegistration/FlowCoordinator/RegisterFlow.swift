import Core
import SwiftUI

enum RegisterRoute: Hashable {
    case personal
    case userName
    case birthdate
    case resume
    case password
    case confirmPassword
}

@MainActor
final class RegistrationDraft: ObservableObject {
    @Published var sin = ""
    @Published var mothersName = ""
    @Published var userName = ""
    @Published var birthdate = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    func clearPasswords() {
        password = ""
        confirmPassword = ""
    }

    func reset() {
        sin = ""
        mothersName = ""
        userName = ""
        birthdate = ""
        clearPasswords()
    }
}

struct RegisterFlow: View {
    private let coreService: any HasCoreService
    private let onBackToLogin: () -> Void
    var onRegisterFinished: () -> Void
    @State private var path: [RegisterRoute] = []
    @StateObject private var draft = RegistrationDraft()

    init(coreService: any HasCoreService,
         onBackToLogin: @escaping () -> Void,
         onRegisterFinished: @escaping () -> Void) {
        self.coreService = coreService
        self.onBackToLogin = onBackToLogin
        self.onRegisterFinished = onRegisterFinished
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            SINFactory.make(draft: draft, onBack: onBackToLogin) {
                path.append(.personal)
            }
            .navigationDestination(for: RegisterRoute.self) { route in
                switch route {
                case .personal:
                    MothersNameInputFactory.make(
                        draft: draft,
                        onBack: {
                        if !path.isEmpty {
                            path.removeLast()
                        }
                    },
                        onContinue: {
                        path.append(.userName)
                    }
                    )
                case .userName:
                    UserNameFactory.make(
                        draft: draft,
                        onBack: {
                        if !path.isEmpty {
                            path.removeLast()
                        }
                    },
                        onContinue: {
                        path.append(.birthdate)
                    }
                    )
                case .birthdate:
                    BirthdateFactory.make(
                        draft: draft,
                        onBack: {
                        if !path.isEmpty {
                            path.removeLast()
                        }
                    },
                        onContinue: {
                        path.append(.resume)
                    }
                    )
                case .resume:
                    ResumeFactory.make(
                        coreService: coreService,
                        draft: draft,
                        onBack: {
                        if !path.isEmpty {
                            path.removeLast()
                        }
                    },
                        onContinue: {
                        path.append(.password)
                    }
                    )
                case .password:
                    PasswordFactory.make(draft: draft, onBack: onBackToLogin) {
                        path.append(.confirmPassword)
                    }
                case .confirmPassword:
                    ConfirmPasswordFactory.make(coreService: coreService, draft: draft, onBack: {
                        if !path.isEmpty {
                            path.removeLast()
                        }
                    }) {
                        draft.reset()
                        onRegisterFinished()
                    }
                }
            }
        }
    }
}
