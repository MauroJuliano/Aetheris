import AetherisDesignSystem
import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String
    @State private var isSendingResetLink = false
    let onBack: () -> Void
    let onSendResetLink: (String) -> Void
    let onBackToLogin: () -> Void

    @FocusState private var isEmailFocused: Bool

    init(
        email: String = "",
        onBack: @escaping () -> Void,
        onSendResetLink: @escaping (String) -> Void,
        onBackToLogin: @escaping () -> Void
    ) {
        self._email = State(initialValue: email)
        self.onBack = onBack
        self.onSendResetLink = onSendResetLink
        self.onBackToLogin = onBackToLogin
    }

    private var isButtonEnabled: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            background

            VStack(alignment: .leading, spacing: 0) {
                header

                Spacer()
                    .frame(height: AppSpacing.xLarge)

                titleSection

                Spacer()
                    .frame(height: 72)

                formSection

                Spacer()
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.top, AppSpacing.medium)
            .padding(.bottom, AppSpacing.large)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

private extension ForgotPasswordView {
    var header: some View {
        Button {
            onBack()
            onBackToLogin()
        } label: {
            Image(systemName: "arrow.left")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(Color.brandPrimaryColor)
                .frame(width: 44, height: 44, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Strings.ForgotPassword.back)
    }

    var titleSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.ForgotPassword.title)
                .font(AppTypography.headline)
                .foregroundStyle(Color.brandPrimaryColor)

            Text(Strings.ForgotPassword.heading)
                .font(AppTypography.screenTitle)
                .foregroundStyle(Color.textPrimary)

            Text(Strings.ForgotPassword.description)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, AppSpacing.xxxSmall)
        }
    }

    var formSection: some View {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    Text(Strings.ForgotPassword.emailLabel)
                        .font(AppTypography.subheadline)
                        .foregroundStyle(Color.textSecondaryColor)

                emailField
            }

            PrimaryButton(
                title: Strings.ForgotPassword.sendResetLink,
                isLoading: isSendingResetLink
            ) {
                sendResetLink()
            }
            .disabled(!isButtonEnabled || isSendingResetLink)
            .opacity(isButtonEnabled ? 1 : 0.45)

            HStack(spacing: AppSpacing.xxSmall) {
                Text(Strings.ForgotPassword.rememberPassword)
                    .foregroundStyle(Color.textSecondaryColor)

                Button(Strings.ForgotPassword.backToLogin) {
                    onBackToLogin()
                }
                .foregroundStyle(Color.brandPrimaryColor)
                .fontWeight(.semibold)
            }
            .font(AppTypography.body)
            .frame(maxWidth: .infinity)
        }
    }

    var emailField: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: "envelope")
                .font(.system(size: 21, weight: .medium))
                .foregroundStyle(Color.brandPrimaryColor)

            TextField(
                "",
                text: $email,
                prompt: Text(Strings.ForgotPassword.emailPlaceholder)
                    .foregroundColor(Color.textTertiary)
                    .font(AppTypography.input)
            )
            .font(AppTypography.body)
            .foregroundStyle(Color.textPrimary)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
            .focused($isEmailFocused)
            .submitLabel(.send)
            .onSubmit {
                sendResetLink()
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .frame(height: 58)
        .background {
            RoundedRectangle(
                cornerRadius: AppRadius.card,
                style: .continuous
            )
            .fill(Color.backgroundColorA)
        }
        .overlay {
            RoundedRectangle(
                cornerRadius: AppRadius.card,
                style: .continuous
            )
            .stroke(
                isEmailFocused
                    ? Color.brandPrimaryColor
                    : Color.brandPrimaryColor.opacity(0.18),
                lineWidth: isEmailFocused ? 1.5 : 1
            )
        }
    }

    var background: some View {
        ZStack {
            Color.backgroundColorA
                .ignoresSafeArea()

            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isEmailFocused = false
        }
    }

    func sendResetLink() {
        let normalizedEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !normalizedEmail.isEmpty else {
            isEmailFocused = true
            return
        }

        guard !isSendingResetLink else {
            return
        }

        isEmailFocused = false
        isSendingResetLink = true

        Task {
            try? await Task.sleep(nanoseconds: 900_000_000)

            await MainActor.run {
                onSendResetLink(normalizedEmail)
                isSendingResetLink = false
                onBackToLogin()
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(
            onBack: {},
            onSendResetLink: { _ in },
            onBackToLogin: {}
        )
    }
}
