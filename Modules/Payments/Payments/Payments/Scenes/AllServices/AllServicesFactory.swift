import SwiftUI

enum AllServicesFactory {
    @MainActor
    static func make(
        onBack: @escaping () -> Void
    ) -> AllServicesView {
        AllServicesView(
            viewModel: AllServicesViewModel(
                service: AllServicesService()
            ),
            onBack: onBack
        )
    }
}
