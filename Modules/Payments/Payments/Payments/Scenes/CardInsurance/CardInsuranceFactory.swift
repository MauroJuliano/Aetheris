import Core
import SwiftUI

enum CardInsuranceFactory {
    @MainActor
    static func make(coreService: any HasCoreService) -> CardInsurance {
        CardInsurance(
            viewModel: CardInsuranceViewModel(
                service: CardInsuranceService(coreService: coreService)
            )
        )
    }
}
