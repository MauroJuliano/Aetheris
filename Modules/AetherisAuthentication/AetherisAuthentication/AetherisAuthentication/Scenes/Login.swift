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
                Text("Hello Again!")
                    .foregroundStyle(.black)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Your financial journey continues. \nLet’s make your next move count.")
                    .foregroundStyle(.gray)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(35)

            Spacer()

            // Email
            HStack {
                TextField(
                    "",
                    text: $login,
                    prompt: Text("Email")
                        .foregroundColor(.black.opacity(0.6))
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
                    prompt: Text("Password")
                        .foregroundColor(.black.opacity(0.6))
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
                Text("Create a new account?")
                    .foregroundStyle(.gray)

                Button {
                    onRegister()
                } label: {
                    Text("Sign up here")
                        .bold()
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .background(Color.backgroundColorA)
    }
}


#Preview {
    Login(onLogin: {}, onRegister: {})
}
