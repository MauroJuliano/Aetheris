import Foundation
import SwiftUI

@MainActor
final class BeneficiaryAddViewModel: ObservableObject {
    @Published var name = ""
    @Published var pixKey = ""
    @Published var selectedImage = Beneficiary.beneficiaries.first?.image ?? ""
    @Published private(set) var isSaving = false
    @Published private(set) var errorMessage: String?

    private let service: any BeneficiaryAddServicing

    init(service: any BeneficiaryAddServicing) {
        self.service = service
    }

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !pixKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func save() async -> Beneficiary? {
        guard isFormValid else {
            errorMessage = "Fill in the required fields."
            return nil
        }

        isSaving = true
        errorMessage = nil
        defer { isSaving = false }

        do {
            return try await service.createBeneficiary(
                name: name,
                pixKey: pixKey,
                image: selectedImage
            )
        } catch {
            errorMessage = "We could not save this beneficiary right now."
            return nil
        }
    }
}
