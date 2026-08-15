import AetherisDesignSystem
import SwiftUI

struct CardLockEffectsSection: View {
    let isBlocked: Bool

    private let effects = CardLockEffect.defaultEffects

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(sectionTitle)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            VStack(spacing: 0) {
                ForEach(Array(effects.enumerated()), id: \.element.id) { index, effect in
                    effectRow(effect)

                    if index < effects.count - 1 {
                        Divider()
                            .padding(.leading, 72)
                    }
                }
            }
            .appCardSurface()
        }
    }

    private var sectionTitle: String {
        isBlocked ? Strings.CardLock.whileBlockedTitle : Strings.CardLock.whenBlockingTitle
    }

    private func effectRow(_ effect: CardLockEffect) -> some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 42, height: 42)

                Image(systemName: effect.icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(effect.title)
                    .font(AppTypography.body)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.textPrimary)

                Text(effect.description)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: AppSpacing.small)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.small)
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        CardLockEffectsSection(isBlocked: false)
        CardLockEffectsSection(isBlocked: true)
    }
    .padding()
    .appScreenBackground()
}
