import Foundation
import SwiftUI

@MainActor
final class BeneficiaryListViewModel: ObservableObject {
    struct Section: Identifiable {
        var id: String { letter }
        let letter: String
        let beneficiaries: [Beneficiary]
    }
    @Published private(set) var isLoading = true
    @Published private(set) var beneficiaries: [Beneficiary] = []
    @Published private(set) var errorMessage: String?

    private let service: any BeneficiaryListServicing

    init(service: any BeneficiaryListServicing) {
        self.service = service
    }

    var recentBeneficiaries: [Beneficiary] { Array(beneficiaries.prefix(4)) }

    func filteredBeneficiaries(query: String) -> [Beneficiary] {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let all = BeneficiaryFixtures.defaults
        guard !query.isEmpty else { return all }
        return all.filter {
            $0.name.localizedCaseInsensitiveContains(query) || $0.pixKey.localizedCaseInsensitiveContains(query)
        }
    }

    func sections(query: String) -> [Section] {
        let sorted = filteredBeneficiaries(query: query).sorted {
            $0.name.localizedStandardCompare($1.name) == .orderedAscending
        }
        let grouped = Dictionary(grouping: sorted, by: \.sectionKey)
        return grouped.keys.sorted().map { Section(letter: $0, beneficiaries: grouped[$0] ?? []) }
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
