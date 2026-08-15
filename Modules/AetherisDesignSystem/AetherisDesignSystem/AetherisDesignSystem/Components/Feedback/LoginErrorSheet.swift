import SwiftUI

public struct ActionErrorSheet: View {
    public let title: String
    public let description: String
    public let primaryButtonTitle: String
    public let secondaryButtonTitle: String?
    public let onPrimaryAction: () -> Void
    public let onSecondaryAction: (() -> Void)?

    public init(
        title: String,
        description: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String? = nil,
        onPrimaryAction: @escaping () -> Void,
        onSecondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.onPrimaryAction = onPrimaryAction
        self.onSecondaryAction = onSecondaryAction
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

            PrimaryButton(title: primaryButtonTitle, action: onPrimaryAction)

            if let secondaryButtonTitle, let onSecondaryAction {
                Button(action: onSecondaryAction) {
                    Text(secondaryButtonTitle)
                        .font(AppTypography.body)
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }
        }
        .padding(AppSpacing.xLarge)
        .presentationDetents([.height(secondaryButtonTitle == nil ? 320 : 360)])
        .presentationDragIndicator(.visible)
        .presentationBackground(Color.backgroundColorA)
    }
}

@available(*, deprecated, renamed: "ActionErrorSheet")
public typealias LoginErrorSheet = ActionErrorSheet

#Preview {
    ActionErrorSheet(
        title: "Action unavailable",
        description: "We couldn't complete this action right now.",
        primaryButtonTitle: "Try again",
        secondaryButtonTitle: "Cancel",
        onPrimaryAction: {},
        onSecondaryAction: {}
    )
}
