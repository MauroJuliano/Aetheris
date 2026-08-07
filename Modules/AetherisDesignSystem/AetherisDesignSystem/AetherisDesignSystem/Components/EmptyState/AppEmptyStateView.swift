import SwiftUI

public struct AppEmptyStateView: View {
    private let title: String
    private let description: String
    private let symbolName: String

    public init(title: String, description: String, symbolName: String = "tray") {
        self.title = title
        self.description = description
        self.symbolName = symbolName
    }

    public var body: some View {
        VStack(spacing: AppSpacing.xLarge) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.10))
                    .frame(width: 140, height: 140)

                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.06))
                    .frame(width: 92, height: 92)

                Image(systemName: symbolName)
                    .font(.system(size: 44, weight: .semibold))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(spacing: AppSpacing.xxSmall) {
                Text(title)
                    .font(AppTypography.sectionTitle)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appScreenBackground()
    }
}

#Preview {
    AppEmptyStateView(
        title: "No items yet",
        description: "Your saved items will appear here.",
        symbolName: "tray"
    )
}
