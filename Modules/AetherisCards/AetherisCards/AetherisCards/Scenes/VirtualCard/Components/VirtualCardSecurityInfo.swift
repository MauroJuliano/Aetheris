import AetherisDesignSystem
import SwiftUI

struct VirtualCardSecurityInfo: View {
    let onLearnMoreTap: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 48, height: 48)

                Image(systemName: "lock.shield")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                Text(Strings.VirtualCard.securityDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)

                Button(Strings.VirtualCard.learnMore, action: onLearnMoreTap)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
                    .buttonStyle(.plain)
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}
