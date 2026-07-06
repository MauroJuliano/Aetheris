import SwiftUI

enum RegisterRoute: Hashable {
    case personal
    case userName
    case birthdate
    case resume
}

struct RegisterFlow: View {
    var onRegisterFinished: () -> Void
    @State private var path: [RegisterRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            SINFactory.make {
                path.append(.personal)
            }
            .navigationDestination(for: RegisterRoute.self) { route in
                switch route {
                case .personal:
                    MothersNameInputFactory.make {
                        path.append(.userName)
                    }
                case .userName:
                    UserNameFactory.make {
                        path.append(.birthdate)
                    }
                case .birthdate:
                    BirthdateView(viewModel: BirthdateViewModel(service: MockBirthdateService())) {
                        path.append(.resume)
                    }
                case .resume:
                    ResumeFactory.make {
                        onRegisterFinished()
                    }
                }
                
            }
        }
    }
}
