import Core
import SwiftUI

enum BeneficiaryListFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onSelect: @escaping (Beneficiary) -> Void,
        onBack: @escaping () -> Void
    ) -> BeneficiaryList {
        BeneficiaryList(
            viewModel: BeneficiaryListViewModel(
                service: BeneficiaryListService(coreService: coreService)
            ),
            onSelect: onSelect,
            onBack: onBack
        )
    }
}
