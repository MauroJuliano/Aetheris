import Foundation

struct CardLockEffect: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
}

extension CardLockEffect {
    static let defaultEffects: [CardLockEffect] = [
        CardLockEffect(
            title: Strings.CardLock.purchasesRefusedTitle,
            description: Strings.CardLock.purchasesRefusedDescription,
            icon: "bag"
        ),
        CardLockEffect(
            title: Strings.CardLock.withdrawalsDisabledTitle,
            description: Strings.CardLock.withdrawalsDisabledDescription,
            icon: "banknote"
        ),
        CardLockEffect(
            title: Strings.CardLock.contactlessDisabledTitle,
            description: Strings.CardLock.contactlessDisabledDescription,
            icon: "wave.3.right"
        ),
        CardLockEffect(
            title: Strings.CardLock.subscriptionsAffectedTitle,
            description: Strings.CardLock.subscriptionsAffectedDescription,
            icon: "arrow.triangle.2.circlepath"
        )
    ]
}
