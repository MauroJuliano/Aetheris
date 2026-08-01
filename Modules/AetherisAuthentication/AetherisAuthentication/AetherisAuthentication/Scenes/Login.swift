import AetherisDesignSystem
import SwiftUI

struct Login: View {
    private enum Field: Hashable {
        case email
        case password
    }

    var onLogin: () -> Void
    var onRegister: () -> Void
    var onForgotPassword: (String) -> Void

    @State private var login = ""
    @State private var password = ""
    @State private var isShowingLoginErrorSheet = false
    @FocusState private var focusedField: Field?

    private let validCredentials: [(email: String, password: String)] = [
        ("melissa@aetheris.app", "1234"),
        ("admin@aetheris.app", "4321")
    ]

    private var canSubmit: Bool {
        login.trimmingCharacters(in: .whitespacesAndNewlines).count >= 5 &&
        password.count >= 4
    }

    private var normalizedLogin: String {
        login.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

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
                .accessibilityIdentifier("login.email")
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { focusedField = .password }
            }
            .appInputField()

            // Password
            HStack {
                SecureField(
                    "",
                    text: $password,
                    prompt: Text(Strings.Login.passwordPlaceholder)
                        .foregroundColor(Color.textTertiary)
                        .font(AppTypography.input)
                )
                .keyboardType(.numberPad)
                .accessibilityIdentifier("login.password")
                .focused($focusedField, equals: .password)
            }
            .appInputField()

            // Login button
            GlowButton(title: Strings.Login.loginButton) {
                guard canSubmit else { return }
                if validCredentials.contains(where: { $0.email == normalizedLogin && $0.password == password }) {
                    onLogin()
                } else {
                    isShowingLoginErrorSheet = true
                }
            }
            .padding()
            .disabled(!canSubmit)
            .opacity(canSubmit ? 1 : 0.55)
            .accessibilityIdentifier("login.submit")

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
                .accessibilityIdentifier("login.register")
            }
            .padding(.bottom, AppSpacing.xxLarge)
        }
        .background {
            ZStack {
                Color.backgroundColorA
                    .ignoresSafeArea()

                Image("login-background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
        .sheet(isPresented: $isShowingLoginErrorSheet) {
            ActionErrorSheet(
                title: Strings.LoginError.title,
                description: Strings.LoginError.description,
                primaryButtonTitle: Strings.LoginError.primaryButton,
                secondaryButtonTitle: Strings.LoginError.secondaryButton,
                onPrimaryAction: {
                    isShowingLoginErrorSheet = false
                },
                onSecondaryAction: {
                    isShowingLoginErrorSheet = false
                    DispatchQueue.main.async {
                        onForgotPassword(login)
                    }
                }
            )
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("login.errorSheet")
        }
        .onChange(of: password) { _, newValue in
            let filtered = newValue.filter(\.isNumber)
            if filtered != newValue {
                password = filtered
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(onLogin: {}, onRegister: {}, onForgotPassword: { _ in })
    }
}
