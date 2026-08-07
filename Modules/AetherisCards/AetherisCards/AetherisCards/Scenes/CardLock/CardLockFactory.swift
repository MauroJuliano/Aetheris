import Core
import Foundation
import SwiftUI

enum CardLockFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        cardId: UUID,
        onBackAction: @escaping () -> Void,
        onHelpTap: @escaping () -> Void = {},
        onCardSettingsTap: @escaping (UUID) -> Void = { _ in },
        onVirtualCardTap: @escaping (UUID) -> Void = { _ in },
        onRequestNewCardTap: @escaping (UUID) -> Void = { _ in }
    ) -> CardLockScreen {
        CardLockScreen(
            viewModel: CardLockViewModel(
                cardId: cardId,
                service: CardLockService(coreService: coreService)
            ),
            onBackAction: onBackAction,
            onHelpTap: onHelpTap,
            onCardSettingsTap: onCardSettingsTap,
            onVirtualCardTap: onVirtualCardTap,
            onRequestNewCardTap: onRequestNewCardTap
        )
    }
}
