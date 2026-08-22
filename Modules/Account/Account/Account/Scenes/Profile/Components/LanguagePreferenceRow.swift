import AetherisDesignSystem
import SwiftUI

struct LanguagePreferenceRow: View {
    let title: String
    let value: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppSpacing.medium) {
                Image(systemName: "globe")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
                    .frame(width: 44, height: 44)
                    .background(Color.brandPrimaryColor.opacity(0.1))
                    .clipShape(Circle())

                Text(title)
                    .font(AppTypography.cardBody)
                    .foregroundStyle(Color.textPrimary)

                Spacer()

                Text(value)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(AppSpacing.medium)
            .contentShape(Rectangle())
            .appCardSurface()
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            HStack(spacing: AppSpacing.medium) {
                SkeletonBlock(width: 44, height: 44, radius: 22)
                SkeletonBlock(width: 88, height: 18, radius: 9)
                Spacer()
                SkeletonBlock(width: 72, height: 14, radius: 7)
            }
            .padding(AppSpacing.medium)
            .appCardSurface()
        } else {
            self
        }
    }
}
