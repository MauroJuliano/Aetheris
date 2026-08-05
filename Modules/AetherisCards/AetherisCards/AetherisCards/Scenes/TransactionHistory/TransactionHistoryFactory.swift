import Core
import Foundation
import SwiftUI

enum TransactionHistoryFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        cardId: UUID
    ) -> TransactionHistoryView {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                service: TransactionHistoryService(
                    coreService: coreService,
                    cardId: cardId
                )
            ),
            onBack: nil
        )
    }

    @MainActor
    static func make(
        coreService: any HasCoreService,
        cardId: UUID,
        onBack: @escaping () -> Void
    ) -> TransactionHistoryView {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                service: TransactionHistoryService(
                    coreService: coreService,
                    cardId: cardId
                )
            ),
            onBack: onBack
        )
    }
}
