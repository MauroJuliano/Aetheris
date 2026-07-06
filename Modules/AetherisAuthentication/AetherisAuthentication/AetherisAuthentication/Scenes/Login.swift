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
                    .font(AppTypography.balanceAmount)
                
                Text("Let's get started")
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.screenTitle)
                    .bold()

                Text("Your financial journey continues. \nLet’s make your next \nmove count.")
                    .foregroundStyle(Color.textTertiary)
                    .font(AppTypography.onboardingBody)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, AppSpacing.formTop)
            .padding(.horizontal, AppSpacing.formHorizontal)

            Spacer()

            // Email
            HStack {
                TextField(
                    "",
                    text: $login,
                    prompt: Text("Enter your email")
                        .foregroundColor(Color.textTertiary)
                        .font(AppTypography.input)
                )
            }
            .appInputField()

            // Password
            HStack {
                TextField(
                    "",
                    text: $password,
                    prompt: Text("Enter your password")
                        .foregroundColor(Color.textTertiary)
                        .font(AppTypography.input)
                )
            }
            .appInputField()

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
