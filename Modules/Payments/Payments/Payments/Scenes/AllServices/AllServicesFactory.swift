import Core
import SwiftUI

enum AllServicesFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void
    ) -> AllServicesView {
        AllServicesView(
            viewModel: AllServicesViewModel(
                service: AllServicesService(coreService: coreService)
            ),
            onBack: onBack
        )
    }
}

