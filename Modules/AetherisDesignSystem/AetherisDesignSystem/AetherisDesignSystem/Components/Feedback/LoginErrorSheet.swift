import SwiftUI

public struct LoginErrorSheet: View {
    public let title: String
    public let description: String
    public let primaryButtonTitle: String
    public let secondaryButtonTitle: String
    public let onTryAgain: () -> Void
    public let onForgotPassword: () -> Void

    public init(
        title: String,
        description: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String,
        onTryAgain: @escaping () -> Void,
        onForgotPassword: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.onTryAgain = onTryAgain
        self.onForgotPassword = onForgotPassword
    }

    public var body: some View {
        VStack(spacing: AppSpacing.large) {
            Circle()
                .fill(Color.error.opacity(0.12))
                .frame(width: 72, height: 72)
                .overlay {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(Color.error)
                }

            VStack(spacing: AppSpacing.small) {
                Text(title)
                    .font(AppTypography.headline.weight(.semibold))
                    .foregroundStyle(Color.textPrimary)

                Text(description)
                    .font(AppTypography.body)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)
            }

            PrimaryButton(title: primaryButtonTitle, action: onTryAgain)

            Button(action: onForgotPassword) {
                Text(secondaryButtonTitle)
                    .font(AppTypography.body)
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
        .padding(AppSpacing.xLarge)
        .presentationDetents([.height(360)])
        .presentationDragIndicator(.visible)
        .presentationBackground(Color.backgroundColorA)
    }
}
