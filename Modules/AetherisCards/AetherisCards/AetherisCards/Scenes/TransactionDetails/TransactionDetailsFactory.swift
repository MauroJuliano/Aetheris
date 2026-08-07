import Core
import Foundation
import SwiftUI

enum TransactionDetailsFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        transactionId: UUID,
        onBackAction: @escaping () -> Void,
        onSupportTap: @escaping (UUID) -> Void = { _ in },
        onShareTap: @escaping (UUID) -> Void = { _ in },
        onDownloadTap: @escaping (UUID) -> Void = { _ in },
        onAddNoteTap: @escaping (UUID) -> Void = { _ in },
        onReportIssueTap: @escaping (UUID) -> Void = { _ in },
        onMerchantTap: @escaping (UUID) -> Void = { _ in },
        onPaymentMethodTap: @escaping (UUID) -> Void = { _ in },
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onBlockMerchantTap: @escaping (UUID) -> Void = { _ in }
    ) -> TransactionDetailsScreen {
        TransactionDetailsScreen(
            viewModel: TransactionDetailsViewModel(
                transactionId: transactionId,
                service: TransactionDetailsService(coreService: coreService)
            ),
            onBackAction: onBackAction,
            onSupportTap: onSupportTap,
            onShareTap: onShareTap,
            onDownloadTap: onDownloadTap,
            onAddNoteTap: onAddNoteTap,
            onReportIssueTap: onReportIssueTap,
            onMerchantTap: onMerchantTap,
            onPaymentMethodTap: onPaymentMethodTap,
            onTransactionHistoryTap: onTransactionHistoryTap,
            onBlockMerchantTap: onBlockMerchantTap
        )
    }
}
