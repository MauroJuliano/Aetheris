import Core
import SwiftUI

enum InsuranceOnboardingFactory {
    @MainActor
    static func make(coreService: any HasCoreService) -> InsuranceOnboarding {
        InsuranceOnboarding(
            viewModel: InsuranceOnboardingViewModel(
                service: InsuranceOnboardingService(coreService: coreService)
            )
        )
    }
}
