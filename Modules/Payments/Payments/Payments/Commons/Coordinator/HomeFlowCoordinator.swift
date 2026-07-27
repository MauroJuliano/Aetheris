import Core
import SwiftUI

struct HomeFlowCoordinator: View {
    let coreService: any HasCoreService
    @Binding var selectedBeneficiary: Beneficiary

    var body: some View {
        HomeAppFactory.make(
            coreService: coreService,
            selectedBeneficiary: $selectedBeneficiary
        )
    }
}
