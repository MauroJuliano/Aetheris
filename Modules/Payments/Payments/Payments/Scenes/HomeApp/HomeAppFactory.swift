import Core
import SwiftUI

enum HomeAppFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onCardTap: @escaping () -> Void,
        onNotificationsTap: @escaping () -> Void,
        onSelectRecipient: @escaping (Beneficiary) -> Void,
        onSeeAllRecipientsTap: @escaping () -> Void,
        onNewRecipientTap: @escaping () -> Void,
        onTransferTap: @escaping () -> Void,
        onMoreTap: @escaping () -> Void,
        onViewReportTap: @escaping () -> Void
    ) -> HomeApp {
        HomeApp(
            viewModel: HomeAppViewModel(service: HomeAppService(coreService: coreService)),
            onCardTap: onCardTap,
            onNotificationsTap: onNotificationsTap,
            onSelectRecipient: onSelectRecipient,
            onSeeAllRecipientsTap: onSeeAllRecipientsTap,
            onNewRecipientTap: onNewRecipientTap,
            onTransferTap: onTransferTap,
            onMoreTap: onMoreTap,
            onViewReportTap: onViewReportTap
        )
    }
}
