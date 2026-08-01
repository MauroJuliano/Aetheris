import SwiftUI

private final class AetherisDesignSystemBundleToken {}

private extension Bundle {
    static var aetherisDesignSystem: Bundle {
        Bundle(for: AetherisDesignSystemBundleToken.self)
    }
}

public struct FullScreenErrorView: View {
    public let title: String
    public let description: String
    public let primaryButtonTitle: String
    public let secondaryButtonTitle: String?
    public let onPrimaryAction: () -> Void
    public let onSecondaryAction: (() -> Void)?

    private let illustrationName: String?
    private let symbolName: String

    public init(
        title: String,
        description: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String? = nil,
        illustrationName: String? = "feedback_error",
        symbolName: String = "cloud.bolt.fill",
        onPrimaryAction: @escaping () -> Void,
        onSecondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.illustrationName = illustrationName
        self.symbolName = symbolName
        self.onPrimaryAction = onPrimaryAction
        self.onSecondaryAction = onSecondaryAction
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: AppSpacing.xLarge + AppSpacing.xxxSmall) {
                errorIllustration

                VStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    Text(title)
                        .font(AppTypography.heroTitle)
                        .foregroundStyle(Color.textPrimary)
                        .multilineTextAlignment(.center)

                    Text(description)
                        .font(AppTypography.button.weight(.regular))
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, AppSpacing.xLarge)
                }
            }

            Spacer()

            VStack(spacing: AppSpacing.large - AppSpacing.xxxSmall) {
                Button(action: onPrimaryAction) {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.large)
                            .fill(Color.backgroundColorA)
                            .appShadow(AppShadow.card)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.pill)
                                    .stroke(Color.border, style: .init(lineWidth: 1))
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)

                        Text(primaryButtonTitle)
                            .foregroundStyle(Color.brandPrimaryColor)
                            .font(AppTypography.headline)
                            .appShadow(AppShadow.control)
                    }
                }
                .accessibilityIdentifier("error.retry")

                if let secondaryButtonTitle, let onSecondaryAction {
                    Button(action: onSecondaryAction) {
                        Text(secondaryButtonTitle)
                            .font(AppTypography.button)
                            .foregroundStyle(Color.brandPrimaryColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                    }
                }
            }
            .padding(.horizontal, AppSpacing.xLarge)
            .padding(.bottom, AppSpacing.xxLarge + AppSpacing.xxxSmall)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appScreenBackground()
        .accessibilityIdentifier("error.screen")
    }

    private var errorIllustration: some View {
        ZStack {
            Circle()
                .fill(Color.error.opacity(0.10))
                .frame(width: 170, height: 170)

            Circle()
                .fill(Color.error.opacity(0.08))
                .frame(width: 110, height: 110)

            if let illustrationName {
                Image(illustrationName, bundle: .aetherisDesignSystem)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
            } else {
                Image(systemName: symbolName)
                    .font(.system(size: 68, weight: .semibold))
                    .foregroundStyle(Color.error)
            }
        }
    }
}
