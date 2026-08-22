import SwiftUI

struct QuickActionCard: View {
    let action: QuickActionItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: action.icon)
                        .font(.system(size: action.icon == "ellipsis" ? 26 : 30, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                        .frame(width: 36, height: 36, alignment: .leading)

                    Spacer()
                }
                .frame(height: 40)

                Spacer(minLength: AppSpacing.small)

                VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                    Text(action.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    if let subtitle = action.subtitle {
                        Text(subtitle)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color.textTertiary)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(minHeight: 52, alignment: .bottom)
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.vertical, AppSpacing.medium)
            .frame(maxWidth: .infinity)
            .frame(height: 148)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color.surface)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(action.title)
        .accessibilityHint(action.subtitle ?? "")
    }
}
