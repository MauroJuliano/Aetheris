import AetherisDesignSystem
import SwiftUI

struct ProfileLoadErrorView: View {
    let isRetrying: Bool
    let onRetry: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color.error)
                .frame(width: 40, height: 40)
                .background(
                    Color.error.opacity(0.12),
                    in: RoundedRectangle(cornerRadius: AppRadius.medium)
                )

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                Text(Strings.Profile.refreshErrorTitle)
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)

                Text(Strings.Profile.refreshErrorDescription)
                    .font(AppTypography.footnote)
                    .foregroundStyle(Color.textSecondaryColor)
            }

            Spacer(minLength: AppSpacing.small)

            Button(action: onRetry) {
                Group {
                    if isRetrying {
                        ProgressView()
                            .tint(Color.error)
                    } else {
                        Label(Strings.Profile.retry, systemImage: "arrow.clockwise")
                    }
                }
                .font(AppTypography.button)
                .foregroundStyle(Color.error)
            }
            .disabled(isRetrying)
            .accessibilityIdentifier("profile.retry.button")
        }
        .padding(AppSpacing.medium)
        .background(
            Color.error.opacity(0.08),
            in: RoundedRectangle(cornerRadius: AppRadius.large)
        )
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.large)
                .stroke(Color.error.opacity(0.2), lineWidth: 1)
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("profile.loadError")
    }
}

#Preview {
    ProfileLoadErrorView(
        isRetrying: false,
        onRetry: {}
    )
    .padding()
    .appScreenBackground()
}
