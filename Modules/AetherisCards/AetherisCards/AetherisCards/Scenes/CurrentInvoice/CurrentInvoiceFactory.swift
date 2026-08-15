import Core
import Foundation
import SwiftUI

enum CurrentInvoiceFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        cardId: UUID,
        onBackAction: @escaping () -> Void,
        onHelpTap: @escaping () -> Void = {},
        onAvailableLimitTap: @escaping () -> Void = {},
        onBestPurchaseDateTap: @escaping () -> Void = {},
        onSpendingChartsTap: @escaping () -> Void = {},
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onPayInvoiceTap: @escaping (UUID) -> Void = { _ in }
    ) -> CurrentInvoiceScreen {
        CurrentInvoiceScreen(
            viewModel: CurrentInvoiceViewModel(
                cardId: cardId,
                service: CurrentInvoiceService(coreService: coreService)
            ),
            onBackAction: onBackAction,
            onHelpTap: onHelpTap,
            onAvailableLimitTap: onAvailableLimitTap,
            onBestPurchaseDateTap: onBestPurchaseDateTap,
            onSpendingChartsTap: onSpendingChartsTap,
            onTransactionHistoryTap: onTransactionHistoryTap,
            onPayInvoiceTap: onPayInvoiceTap
        )
    }
}
