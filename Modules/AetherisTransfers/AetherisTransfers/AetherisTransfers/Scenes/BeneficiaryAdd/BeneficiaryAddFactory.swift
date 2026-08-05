import Core
import SwiftUI

enum BeneficiaryAddFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void,
        onComplete: @escaping (Beneficiary) -> Void
    ) -> BeneficiaryAddView {
        BeneficiaryAddView(
            viewModel: BeneficiaryAddViewModel(
                service: BeneficiaryAddService(coreService: coreService)
            ),
            onBack: onBack,
            onComplete: onComplete
        )
    }
}
