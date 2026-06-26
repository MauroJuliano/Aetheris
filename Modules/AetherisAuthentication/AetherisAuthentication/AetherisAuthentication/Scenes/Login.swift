import AetherisDesignSystem
import SwiftUI

struct Login: View {
    var onLogin: () -> Void
    var onRegister: () -> Void

    @State private var login = ""
    @State private var password = ""

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Welcome back!")
                    .foregroundStyle(Color.brandPrimaryColor)
                    .font(.title)
                
                Text("Let's get started")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .bold()

                Text("Your financial journey continues. \nLet’s make your next \nmove count.")
                    .foregroundStyle(Color.textTertiary)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 60)
            .padding(.horizontal, 35)

            Spacer()

            // Email
            HStack {
                TextField(
                    "",
                    text: $login,
                    prompt: Text("Enter your email")
                        .foregroundColor(.gray.opacity(0.6))
                        .font(.body)
                )
                .foregroundStyle(.black)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            .underlined(color: .gray.opacity(0.3))
            .padding(.horizontal, 35)
            .padding(.vertical, 10)

            // Password
            HStack {
                TextField(
                    "",
                    text: $password,
                    prompt: Text("Enter your password")
                        .foregroundColor(.gray.opacity(0.6))
                        .font(.body)
                )
                .foregroundStyle(.black)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            .underlined(color: .gray.opacity(0.3))
            .padding(.horizontal, 35)
            .padding(.vertical, 10)

            // Login button
            GlowButton(title: "Login") {
                onLogin()
            }
            .padding()

            // Register
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)

                Button {
                    onRegister()
                } label: {
                    Text("Sign up here")
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }
            .padding(.bottom, 30)
        }
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}


#Preview {
    Login(onLogin: {}, onRegister: {})
}
