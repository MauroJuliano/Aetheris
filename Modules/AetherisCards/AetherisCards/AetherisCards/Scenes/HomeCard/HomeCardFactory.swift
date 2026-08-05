import Core
import Foundation
import SwiftUI

enum HomeCardFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBackAction: (() -> Void)? = nil,
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in }
    ) -> CardHome {
        CardHome(
            viewModel: HomeCardViewModel(service: HomeCardService(coreService: coreService)),
            onBackAction: onBackAction,
            onTransactionHistoryTap: onTransactionHistoryTap
        )
    }
}
