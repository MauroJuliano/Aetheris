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
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.screenTitle)
                    .bold()

                Text("Your financial journey continues. \nLet’s make your next \nmove count.")
                    .foregroundStyle(Color.textTertiary)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 60)
            .padding(.horizontal, AppSpacing.formHorizontal)

            Spacer()

            // Email
            HStack {
                TextField(
                    "",
                    text: $login,
                    prompt: Text("Enter your email")
                        .foregroundColor(Color.textTertiary)
                        .font(AppTypography.body)
                )
                .foregroundStyle(Color.textPrimary)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            .underlined(color: Color.border)
            .padding(.horizontal, AppSpacing.formHorizontal)
            .padding(.vertical, AppSpacing.xSmall)

            // Password
            HStack {
                TextField(
                    "",
                    text: $password,
                    prompt: Text("Enter your password")
                        .foregroundColor(Color.textTertiary)
                        .font(AppTypography.body)
                )
                .foregroundStyle(Color.textPrimary)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            .underlined(color: Color.border)
            .padding(.horizontal, AppSpacing.formHorizontal)
            .padding(.vertical, AppSpacing.xSmall)

            // Login button
            GlowButton(title: "Login") {
                onLogin()
            }
            .padding()

            // Register
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(Color.textSecondaryColor)

                Button {
                    onRegister()
                } label: {
                    Text("Sign up here")
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }
            .padding(.bottom, AppSpacing.xxLarge)
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
