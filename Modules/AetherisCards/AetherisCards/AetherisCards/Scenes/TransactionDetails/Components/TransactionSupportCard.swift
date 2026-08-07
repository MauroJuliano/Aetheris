import AetherisDesignSystem
import SwiftUI

struct TransactionSupportCard: View {
    let onSupportTap: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.1))
                    .frame(width: 48, height: 48)

                Image(systemName: "shield.checkered")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.TransactionDetails.needHelp)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(Strings.TransactionDetails.supportDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Button(Strings.TransactionDetails.getSupport, action: onSupportTap)
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.brandPrimaryColor)
                .padding(.horizontal, AppSpacing.medium)
                .frame(height: 40)
                .overlay {
                    Capsule().stroke(Color.brandPrimaryColor.opacity(0.4))
                }
                .buttonStyle(.plain)
        }
        .padding(AppSpacing.medium)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}
