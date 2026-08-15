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
            onBack: nil,
            onTransactionTap: { _ in }
        )
    }

    @MainActor
    static func make(
        coreService: any HasCoreService,
        cardId: UUID,
        onBack: @escaping () -> Void,
        onTransactionTap: @escaping (UUID) -> Void = { _ in }
    ) -> TransactionHistoryView {
        TransactionHistoryView(
            viewModel: TransactionHistoryViewModel(
                service: TransactionHistoryService(
                    coreService: coreService,
                    cardId: cardId
                )
            ),
            onBack: onBack,
            onTransactionTap: onTransactionTap
        )
    }
}
