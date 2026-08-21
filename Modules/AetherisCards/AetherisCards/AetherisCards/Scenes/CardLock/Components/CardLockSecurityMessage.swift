import AetherisDesignSystem
import SwiftUI

struct CardLockSecurityMessage: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 48, height: 48)

                Image(systemName: "shield.checkered")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.CardLock.moneyIsSafeTitle)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(Strings.CardLock.moneyIsSafeDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}

extension CardLockSecurityMessage {
    @ViewBuilder func toSkeleton(enable: Bool) -> some View {
        if enable { CardLockRowSkeleton() } else { self }
    }
}

#Preview {
    CardLockSecurityMessage()
        .padding()
        .appScreenBackground()
}
