import Core
import SwiftUI

enum HomeCardFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBackAction: (() -> Void)? = nil,
        onTransactionHistoryTap: @escaping () -> Void = {}
    ) -> CardHome {
        CardHome(
            viewModel: HomeCardViewModel(service: HomeCardService(coreService: coreService)),
            onBackAction: onBackAction,
            onTransactionHistoryTap: onTransactionHistoryTap
        )
    }
}
