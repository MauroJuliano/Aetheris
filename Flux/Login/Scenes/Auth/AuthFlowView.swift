import SwiftUI

struct AppRootView: View {
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
            RegisterFlowView(
                onRegisterFinished: {
                    flow = .login   // ou .main se quiser logar direto
                }
            )

        case .main:
            TabBarView()
        }
    }
}
