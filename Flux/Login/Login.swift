import SwiftUI

enum Route: Hashable {
    case login
    case register
    case forgotPassword
}

struct Login: View {
    @State var login = ""
    @State var password = ""
    @State var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(.systemGray6) // or Color.blue, Color.black, etc.
                    .ignoresSafeArea()
                
                VStack() {
                    Text("Hello Again!")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding()
                    
                    Text("Welcome back You've been missing!")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                        .padding()
                    
                    Spacer()
                    
                    TextField("Enter your email", text: $login)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    TextField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button {
                        path.append(.login)
                    } label: {
                        Text("Login")
                    }
                    .padding()
                    
                    HStack() {
                        Text("Create a new account?")
                        Button {
                            
                        } label: {
                            Text("Sign up here")
                                .bold()
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .login:
                HomeApp()
            case .register:
                HomeApp()
            case .forgotPassword:
                HomeApp()
            }
        }
    }
}

#Preview {
    Login()
}
