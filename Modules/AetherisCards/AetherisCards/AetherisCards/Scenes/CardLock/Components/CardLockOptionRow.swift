import AetherisDesignSystem
import SwiftUI

struct CardLockOptionRow: View {
    let title: String
    let description: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.medium) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(width: 42, height: 42)

                    Image(systemName: icon)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                }

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(title)
                        .font(AppTypography.body)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.textPrimary)

                    Text(description)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: AppSpacing.small)

                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.small)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
