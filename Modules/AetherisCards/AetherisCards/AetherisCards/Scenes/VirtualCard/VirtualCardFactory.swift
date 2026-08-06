import Core
import Foundation
import SwiftUI

enum VirtualCardFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        physicalCardId: UUID,
        onBackAction: @escaping () -> Void,
        onSettingsTap: @escaping () -> Void = {},
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onTransactionTap: @escaping (UUID) -> Void = { _ in }
    ) -> VirtualCardScreen {
        VirtualCardScreen(
            viewModel: VirtualCardViewModel(
                physicalCardId: physicalCardId,
                service: VirtualCardService(coreService: coreService)
            ),
            onBackAction: onBackAction,
            onSettingsTap: onSettingsTap,
            onTransactionHistoryTap: onTransactionHistoryTap,
            onTransactionTap: onTransactionTap
        )
    }
}
