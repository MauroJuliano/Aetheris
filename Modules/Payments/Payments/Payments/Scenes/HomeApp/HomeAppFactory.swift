import Core
import SwiftUI

enum HomeAppFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        selectedBeneficiary: Binding<Beneficiary>
    ) -> HomeApp {
        HomeApp(
            viewModel: HomeAppViewModel(service: HomeAppService(coreService: coreService)),
            coreService: coreService,
            selectedBeneficiary: selectedBeneficiary
        )
    }
}
