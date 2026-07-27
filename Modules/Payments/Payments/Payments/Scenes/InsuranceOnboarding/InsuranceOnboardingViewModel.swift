import Foundation
import SwiftUI

@MainActor
final class InsuranceOnboardingViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var benefits: [Benefits] = []
    @Published private(set) var errorMessage: String?

    private let service: any InsuranceOnboardingServicing

    init(service: any InsuranceOnboardingServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            benefits = try await service.loadBenefits()
        } catch {
            benefits = []
            errorMessage = Strings.Common.errorSubmit
        }

        isLoading = false
    }
}
