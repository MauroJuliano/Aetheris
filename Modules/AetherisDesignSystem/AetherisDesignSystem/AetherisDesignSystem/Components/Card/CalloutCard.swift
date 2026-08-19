import SwiftUI

public struct CalloutCard: View {
    public let title: String
    public let description: String
    public let buttonTitle: String
    public let iconName: String
    public let onButtonTap: () -> Void

    public init(
        title: String,
        description: String,
        buttonTitle: String,
        iconName: String,
        onButtonTap: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.iconName = iconName
        self.onButtonTap = onButtonTap
    }

    public var body: some View {
        calloutContent
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            CalloutCardSkeleton(
                titleWidth: 102,
                descriptionWidth: 220,
                buttonWidth: 96
            )
        } else {
            self
        }
    }

    private var calloutContent: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.1))
                    .frame(width: 48, height: 48)

                Image(systemName: iconName)
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(title)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(description)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Button(buttonTitle, action: onButtonTap)
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.brandPrimaryColor)
                .padding(.horizontal, AppSpacing.medium)
                .frame(height: 40)
                .overlay {
                    Capsule()
                        .stroke(Color.brandPrimaryColor.opacity(0.4))
                }
                .buttonStyle(.plain)
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        CalloutCard(
            title: "Need help?",
            description: "If you have any questions about this transaction, we're here to help.",
            buttonTitle: "Get support",
            iconName: "shield.checkered",
            onButtonTap: {}
        )
        .toSkeleton(enable: true)
    }
    .padding()
    .appScreenBackground()
}
