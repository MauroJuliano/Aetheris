import Core
import Foundation
import SwiftUI

enum HomeCardFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        initialSelectedCardId: UUID? = nil,
        selectedCardRequestId: UUID? = nil,
        onSelectedCardRequestApplied: @escaping () -> Void = {},
        onBackAction: (() -> Void)? = nil,
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onVirtualCardTap: @escaping (UUID) -> Void = { _ in },
        onInvoiceTap: @escaping (UUID) -> Void = { _ in }
    ) -> CardHome {
        CardHome(
            viewModel: HomeCardViewModel(service: HomeCardService(coreService: coreService)),
            initialSelectedCardId: initialSelectedCardId,
            selectedCardRequestId: selectedCardRequestId,
            onSelectedCardRequestApplied: onSelectedCardRequestApplied,
            onBackAction: onBackAction,
            onTransactionHistoryTap: onTransactionHistoryTap,
            onVirtualCardTap: onVirtualCardTap,
            onInvoiceTap: onInvoiceTap
        )
    }
}
