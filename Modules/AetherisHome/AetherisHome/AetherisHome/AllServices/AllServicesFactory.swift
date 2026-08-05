import SwiftUI

enum AllServicesFactory {
    @MainActor
    static func make(
        onBack: @escaping () -> Void,
        onSelect: @escaping (AllServicesItem.Route) -> Void
    ) -> AllServicesView {
        AllServicesView(
            viewModel: AllServicesViewModel(
                service: AllServicesService()
            ),
            onBack: onBack,
            onSelect: onSelect
        )
    }
}
