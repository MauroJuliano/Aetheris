import Foundation
import SwiftUI

@MainActor
final class BeneficiaryListViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var beneficiaries: [Beneficiary] = []
    @Published private(set) var errorMessage: String?

    private let service: any BeneficiaryListServicing

    init(service: any BeneficiaryListServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let response = try await service.loadBeneficiaryList()
            beneficiaries = Array(response.beneficiaries.prefix(4))
        } catch {
            beneficiaries = []
            errorMessage = Strings.BeneficiaryList.loadFailed
        }
    }
}
