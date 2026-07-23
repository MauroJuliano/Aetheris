import SwiftUI

enum BeneficiaryListFactory {
    @MainActor
    static func make(
        onSelect: @escaping (Beneficiary) -> Void,
        onBack: @escaping () -> Void
    ) -> BeneficiaryList {
        BeneficiaryList(
            viewModel: BeneficiaryListViewModel(),
            onSelect: onSelect,
            onBack: onBack
        )
    }
}
