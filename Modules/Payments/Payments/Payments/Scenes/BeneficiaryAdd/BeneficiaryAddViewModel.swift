import Foundation
import SwiftUI

@MainActor
final class BeneficiaryAddViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published private(set) var isSearching = false
    @Published private(set) var errorMessage: String?

    private let service: any BeneficiaryAddServicing

    init(service: any BeneficiaryAddServicing) {
        self.service = service
    }

    var isFormValid: Bool {
        !searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func searchBeneficiary() async -> Beneficiary? {
        guard isFormValid else {
            errorMessage = Strings.BeneficiaryAdd.invalidSearch
            return nil
        }

        isSearching = true
        errorMessage = nil
        defer { isSearching = false }

        do {
            return try await service.findBeneficiary(
                identifier: searchTerm
            )
        } catch {
            errorMessage = Strings.BeneficiaryAdd.searchFailed
            return nil
        }
    }
}
