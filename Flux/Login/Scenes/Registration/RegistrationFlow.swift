import SwiftUI

enum RegisterRoute: Hashable {
    case personal
    case userName
    case birthdate
}

struct RegisterFlowView: View {
    var onRegisterFinished: () -> Void
    @State private var path: [RegisterRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            SocialInsuranceNumberEntryView {
                path.append(.personal)
            }
            .navigationDestination(for: RegisterRoute.self) { route in
                switch route {
                case .personal:
                    MothersNameInputView {
                        path.append(.userName)
                    }
                case .userName:
                    UserNameView {
                        path.append(.birthdate)
                    }
                case .birthdate:
                    BirthdateView {
                        onRegisterFinished()
                    }
                }
            
            }
        }
    }
}
