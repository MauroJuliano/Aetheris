import Core
import Foundation
import SwiftUI

enum HomeCardFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        initialSelectedCardId: UUID? = nil,
        onBackAction: (() -> Void)? = nil,
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in }
    ) -> CardHome {
        CardHome(
            viewModel: HomeCardViewModel(service: HomeCardService(coreService: coreService)),
            initialSelectedCardId: initialSelectedCardId,
            onBackAction: onBackAction,
            onTransactionHistoryTap: onTransactionHistoryTap
        )
    }
}
