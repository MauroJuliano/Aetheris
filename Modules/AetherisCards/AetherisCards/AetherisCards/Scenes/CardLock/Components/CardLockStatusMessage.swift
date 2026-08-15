import AetherisDesignSystem
import SwiftUI

struct CardLockStatusMessage: View {
    let isBlocked: Bool

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            icon

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(title)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(description)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var icon: some View {
        ZStack {
            Circle()
                .fill(accentColor.opacity(0.12))
                .frame(width: 58, height: 58)

            Image(systemName: isBlocked ? "lock.fill" : "checkmark.circle")
                .font(.system(size: 27, weight: .medium))
                .foregroundStyle(accentColor)
        }
    }

    private var title: String {
        isBlocked ? Strings.CardLock.cardIsBlocked : Strings.CardLock.cardIsUnlocked
    }

    private var description: String {
        isBlocked ? Strings.CardLock.blockedStatusDescription : Strings.CardLock.unblockedStatusDescription
    }

    private var accentColor: Color {
        isBlocked ? Color.error : Color.success
    }

    private var backgroundColor: Color {
        accentColor.opacity(0.06)
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        CardLockStatusMessage(isBlocked: false)
        CardLockStatusMessage(isBlocked: true)
    }
    .padding()
    .appScreenBackground()
}
