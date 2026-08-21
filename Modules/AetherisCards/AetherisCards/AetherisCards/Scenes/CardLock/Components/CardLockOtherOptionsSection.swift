import AetherisDesignSystem
import SwiftUI

struct CardLockOtherOptionsSection: View {
    let card: CardLockModel
    let onCardSettingsTap: (UUID) -> Void
    let onVirtualCardTap: (UUID) -> Void
    let onRequestNewCardTap: (UUID) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.CardLock.otherOptions).font(AppTypography.body).bold().foregroundStyle(Color.textPrimary)
            VStack(spacing: 0) {
                CardLockOptionRow(title: Strings.CardLock.cardSettings, description: Strings.CardLock.cardSettingsDescription, icon: "gearshape") { onCardSettingsTap(card.id) }
                Divider().padding(.leading, 72)
                CardLockOptionRow(title: Strings.CardLock.virtualCard, description: Strings.CardLock.virtualCardDescription, icon: "creditcard") { onVirtualCardTap(card.id) }
                Divider().padding(.leading, 72)
                CardLockOptionRow(title: Strings.CardLock.requestNewCard, description: Strings.CardLock.requestNewCardDescription, icon: "creditcard.and.123") { onRequestNewCardTap(card.id) }
            }.appCardSurface()
        }
    }

    @ViewBuilder func toSkeleton(enable: Bool) -> some View {
        if enable { CardLockEffectsSectionSkeleton() } else { self }
    }
}
