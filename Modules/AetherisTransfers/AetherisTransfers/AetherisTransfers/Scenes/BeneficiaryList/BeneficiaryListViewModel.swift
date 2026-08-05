import Foundation
import SwiftUI

@MainActor
final class BeneficiaryListViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var beneficiaries: [Beneficiary]

    private let service: any BeneficiaryListServicing

    init(service: any BeneficiaryListServicing) {
        self.service = service
        self.beneficiaries = Array(BeneficiaryFixtures.defaults.prefix(4))
    }

    func load() async {
        do {
            let response = try await service.loadBeneficiaryList()
            beneficiaries = Array(response.beneficiaries.prefix(4))
        } catch {
            beneficiaries = Array(BeneficiaryFixtures.defaults.prefix(4))
        }
        isLoading = false
    }
}
