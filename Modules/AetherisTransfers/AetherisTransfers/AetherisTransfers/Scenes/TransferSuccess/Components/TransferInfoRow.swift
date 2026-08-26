import AetherisDesignSystem
import SwiftUI

struct TransferInfoRow: View {
    let icon: String?
    var imageName: String?
    let title: String
    let primary: String
    let secondary: String?

    init(
        icon: String? = nil,
        imageName: String? = nil,
        title: String,
        primary: String,
        secondary: String? = nil
    ) {
        self.icon = icon
        self.imageName = imageName
        self.title = title
        self.primary = primary
        self.secondary = secondary
    }

    var body: some View {
        HStack(spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.13))
                    .frame(width: 58, height: 58)

                if let imageName {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color.brandPrimaryColor)
                } else if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                Text(title)
                    .font(AppTypography.cellCaption.weight(.medium))
                    .foregroundStyle(Color.textSecondaryColor)

                Text(primary)
                    .font(AppTypography.onboardingBody.weight(.semibold))
                    .foregroundStyle(Color.textPrimary)

                if let secondary {
                    Text(secondary)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                }
            }
        }
    }
}
