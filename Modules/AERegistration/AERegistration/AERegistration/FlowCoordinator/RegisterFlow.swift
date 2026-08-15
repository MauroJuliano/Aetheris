import Core
import SwiftUI

enum RegisterRoute: Hashable {
    case personal
    case userName
    case birthdate
    case resume
    case editSin
    case editMothersName
    case editUserName
    case editBirthdate
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

extension RegistrationDraft {
    static var previewFilled: RegistrationDraft {
        let draft = RegistrationDraft()
        draft.sin = "123456789"
        draft.mothersName = "Mary Johnson"
        draft.userName = "Melissa Mccarthy"
        draft.birthdate = "08/17/1990"
        draft.password = "1234"
        draft.confirmPassword = "1234"
        return draft
    }
}

struct RegisterFlow: View {
    private let coreService: any HasCoreService
    private let onBackToLogin: () -> Void
    var onRegisterFinished: () -> Void
    @State private var path: [RegisterRoute] = []
    @StateObject private var draft = RegistrationDraft()
    @State private var isOnboardingPresented = false

    init(coreService: any HasCoreService,
         onBackToLogin: @escaping () -> Void,
         onRegisterFinished: @escaping () -> Void) {
        self.coreService = coreService
        self.onBackToLogin = onBackToLogin
        self.onRegisterFinished = onRegisterFinished
    }
    
    var body: some View {
        if isOnboardingPresented {
            OnboardingView(
                onFinish: finishRegistration
            )
        } else {
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
                            },
                            onEditTap: { kind in
                                switch kind {
                                case .sin:
                                    path.append(.editSin)

                                case .mothersName:
                                    path.append(.editMothersName)

                                case .userName:
                                    path.append(.editUserName)

                                case .birthdate:
                                    path.append(.editBirthdate)
                                }
                            }
                        )
                    case .editSin:
                        SINFactory.make(
                            draft: draft,
                            onBack: popToResume,
                            onContinue: popToResume
                        )
                    case .editMothersName:
                        MothersNameInputFactory.make(
                            draft: draft,
                            onBack: popToResume,
                            onContinue: popToResume
                        )
                    case .editUserName:
                        UserNameFactory.make(
                            draft: draft,
                            onBack: popToResume,
                            onContinue: popToResume
                        )
                    case .editBirthdate:
                        BirthdateFactory.make(
                            draft: draft,
                            onBack: popToResume,
                            onContinue: popToResume
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
                            isOnboardingPresented = true
                        }
                    }
                }
            }
        }
    }

    private func finishRegistration() {
        draft.reset()
        onRegisterFinished()
    }

    private func popToResume() {
        guard !path.isEmpty else {
            return
        }

        path.removeLast()
    }
}

#Preview {
    RegisterFlow(
        coreService: DemoCoreService(delay: 0),
        onBackToLogin: {},
        onRegisterFinished: {}
    )
}
