import Core
import SwiftUI

enum TransactionHistoryFactory {
    @MainActor
    static func make(coreService: any HasCoreService) -> TransactionHistoryView {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                service: TransactionHistoryService(coreService: coreService)
            ),
            onBack: nil
        )
    }

    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void
    ) -> TransactionHistoryView {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                service: TransactionHistoryService(coreService: coreService)
            ),
            onBack: onBack
        )
    }
}
