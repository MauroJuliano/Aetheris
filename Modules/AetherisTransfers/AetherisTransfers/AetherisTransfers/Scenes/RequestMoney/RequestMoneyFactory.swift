import Core
import Foundation
import SwiftUI

enum RequestMoneyFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBackAction: @escaping () -> Void,
        onHelpTap: @escaping () -> Void = {},
        onContactSearchTap: @escaping () -> Void = {},
        onShareRequestTap: @escaping () -> Void = {},
        onSuccess: @escaping (MoneyRequestModel) -> Void = { _ in }
    ) -> RequestMoneyScreen {
        RequestMoneyScreen(
            viewModel: RequestMoneyViewModel(
                service: RequestMoneyService(coreService: coreService)
            ),
            onBackAction: onBackAction,
            onHelpTap: onHelpTap,
            onContactSearchTap: onContactSearchTap,
            onShareRequestTap: onShareRequestTap,
            onSuccess: onSuccess
        )
    }
}
