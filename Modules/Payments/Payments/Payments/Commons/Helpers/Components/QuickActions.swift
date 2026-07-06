import AetherisDesignSystem
import SwiftUI


struct QuickActions: View {
    private let actions: [QuickActionItem] = [
        .init(title: "Transfer", subtitle: "Send money", icon: "arrow.right.arrow.left"),
        .init(title: "Request", subtitle: "Receive money", icon: "arrow.down.left.arrow.up.right"),
        .init(title: "More", subtitle: "All services", icon: "ellipsis")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            Text("What would you like to do ?")
                .font(AppTypography.headline)
                .foregroundStyle(Color.textPrimary)

            HStack(spacing: AppSpacing.medium) {
                ForEach(actions) { action in
                    QuickActionCard(action: action)
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

struct QuickActionItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
}

struct QuickActionCard: View {
    let action: QuickActionItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            iconView

            Spacer(minLength: AppSpacing.small)

            textContent
        }
        .padding(.horizontal, AppSpacing.large)
        .padding(.vertical, AppSpacing.medium)
        .frame(maxWidth: .infinity)
        .frame(height: 132)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color.surface)
        )
    }

    private var iconView: some View {
        HStack {
            Image(systemName: action.icon)
                .font(.system(size: action.icon == "ellipsis" ? 26 : 30, weight: .semibold))
                .foregroundStyle(Color.brandPrimaryColor)
                .frame(width: 36, height: 36, alignment: .leading)

            Spacer()
        }
        .frame(height: 40)
    }

    private var textContent: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
            Text(action.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)

            Text(action.subtitle)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.textTertiary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(height: 36, alignment: .bottom)
    }
}

#Preview {
    QuickActions()
}
