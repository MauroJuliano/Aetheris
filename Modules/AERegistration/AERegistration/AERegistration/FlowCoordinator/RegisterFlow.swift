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
    @Published var sin: String = "" {
        didSet { persist() }
    }

    @Published var mothersName: String = "" {
        didSet { persist() }
    }

    @Published var userName: String = "" {
        didSet { persist() }
    }

    @Published var birthdate: String = "" {
        didSet { persist() }
    }

    @Published var password: String = "" {
        didSet { persist() }
    }

    @Published var confirmPassword: String = "" {
        didSet { persist() }
    }

    private let persistence = AppPersistenceController.shared
    private let record: RegistrationDraftRecord
    private var shouldPersist = true

    init() {
        record = persistence.registrationDraftRecord()
        sin = record.sin
        mothersName = record.mothersName
        userName = record.userName
        birthdate = record.birthdate
        password = record.password
        confirmPassword = record.confirmPassword
    }

    func reset() {
        shouldPersist = false
        sin = ""
        mothersName = ""
        userName = ""
        birthdate = ""
        password = ""
        confirmPassword = ""
        shouldPersist = true
        persist()
    }

    private func persist() {
        guard shouldPersist else { return }
        record.sin = sin
        record.mothersName = mothersName
        record.userName = userName
        record.birthdate = birthdate
        record.password = password
        record.confirmPassword = confirmPassword
        persistence.saveChanges()
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
            SINFactory.make(coreService: coreService, draft: draft, onBack: onBackToLogin) {
                path.append(.personal)
            }
            .navigationDestination(for: RegisterRoute.self) { route in
                switch route {
                case .personal:
                    MothersNameInputFactory.make(
                        coreService: coreService,
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
                        coreService: coreService,
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
                        coreService: coreService,
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
