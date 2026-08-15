import Core
import SwiftUI

enum AllServicesFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void,
        onSelect: @escaping (AllServicesItem.Route) -> Void
    ) -> AllServicesView {
        AllServicesView(
            viewModel: AllServicesViewModel(
                service: AllServicesService(coreService: coreService)
            ),
            onBack: onBack,
            onSelect: onSelect
        )
    }
}
