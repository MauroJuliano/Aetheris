import Foundation
import SwiftUI

@MainActor
final class BeneficiaryListViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var beneficiaries: [Beneficiary]

    init(beneficiaries: [Beneficiary] = Beneficiary.beneficiaries) {
        self.beneficiaries = beneficiaries
    }

    func load() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        isLoading = false
    }
}
