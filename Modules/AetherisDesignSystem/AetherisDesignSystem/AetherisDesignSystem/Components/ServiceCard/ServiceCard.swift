import SwiftUI

public struct ServiceCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let accentColor: Color
    let action: () -> Void

    public init(
        title: String,
        subtitle: String,
        icon: String,
        accentColor: Color,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.accentColor = accentColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                ZStack {
                    RoundedRectangle(
                        cornerRadius: AppRadius.large,
                        style: .continuous
                    )
                    .fill(accentColor.opacity(0.12))
                    .frame(width: 44, height: 44)

                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(accentColor)
                }

                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(2)

                Text(subtitle)
                    .font(AppTypography.footnote)
                    .foregroundStyle(Color.textSecondaryColor)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
            .padding(AppSpacing.medium)
            .appCardSurface(
                radius: AppRadius.large,
                stroke: Color.border,
                shadow: AppShadow.card
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityHint(subtitle)
    }
}

public extension ServiceCard {
    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            ServiceCardSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    ServiceCard(
        title: "Transfer Money",
        subtitle: "Send money in seconds",
        icon: "arrow.right.arrow.left",
        accentColor: .brandPrimaryColor,
        action: {}
    )
    .padding()
    .appScreenBackground()
}
