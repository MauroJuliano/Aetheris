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
                Text(Strings.Login.welcomeBack)
                    .foregroundStyle(Color.brandPrimaryColor)
                    .font(AppTypography.balanceAmount)

                Text(Strings.Login.getStarted)
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.screenTitle)
                    .bold()

                Text(Strings.Login.journey)
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
                    prompt: Text(Strings.Login.emailPlaceholder)
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
                    prompt: Text(Strings.Login.passwordPlaceholder)
                        .foregroundColor(Color.textTertiary)
                        .font(AppTypography.input)
                )
            }
            .appInputField()

            // Login button
            GlowButton(title: Strings.Login.loginButton) {
                onLogin()
            }
            .padding()

            // Register
            HStack {
                Text(Strings.Login.dontHaveAccount)
                    .foregroundStyle(Color.textSecondaryColor)

                Button {
                    onRegister()
                } label: {
                    Text(Strings.Login.signUp)
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
