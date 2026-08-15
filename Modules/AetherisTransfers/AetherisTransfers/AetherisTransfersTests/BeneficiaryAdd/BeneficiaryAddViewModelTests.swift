import Foundation
import Testing
@testable import AetherisTransfers

@MainActor
@Suite("BeneficiaryAddViewModel")
struct BeneficiaryAddViewModelTests {
    @Test(arguments: ["", "   ", "\n"])
    func searchBeneficiary_rejectsBlankSearchWithoutCallingService(searchTerm: String) async {
        let service = BeneficiaryAddServiceSpy(result: .failure(URLError(.badURL)))
        let sut = BeneficiaryAddViewModel(service: service)
        sut.searchTerm = searchTerm

        let beneficiary = await sut.searchBeneficiary()

        #expect(beneficiary == nil)
        #expect(!sut.isFormValid)
        #expect(!sut.isSearching)
        #expect(sut.errorMessage == Strings.BeneficiaryAdd.invalidSearch)
        #expect(service.searches.isEmpty)
    }

    @Test
    func searchBeneficiary_returnsResultAndClearsPreviousError() async {
        let expected = Beneficiary(name: "Sophie Keller", pixKey: "sophie.keller@aetheris.app", image: "sophie", hasDivider: true)
        let service = BeneficiaryAddServiceSpy(result: .success(expected))
        let sut = BeneficiaryAddViewModel(service: service)
        sut.searchTerm = "sophie.keller@aetheris.app"

        let beneficiary = await sut.searchBeneficiary()

        #expect(beneficiary == expected)
        #expect(!sut.isSearching)
        #expect(sut.errorMessage == nil)
        #expect(service.searches == ["sophie.keller@aetheris.app"])
    }

    @Test
    func searchBeneficiary_setsError_whenServiceFails() async {
        let service = BeneficiaryAddServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = BeneficiaryAddViewModel(service: service)
        sut.searchTerm = "missing@example.com"

        let beneficiary = await sut.searchBeneficiary()

        #expect(beneficiary == nil)
        #expect(!sut.isSearching)
        #expect(sut.errorMessage == Strings.BeneficiaryAdd.searchFailed)
        #expect(service.searches.count == 1)
    }
}

private final class BeneficiaryAddServiceSpy: BeneficiaryAddServicing {
    enum Result {
        case success(Beneficiary)
        case failure(Error)
    }

    let result: Result
    private(set) var searches: [String] = []

    init(result: Result) { self.result = result }

    func findBeneficiary(identifier: String) async throws -> Beneficiary {
        searches.append(identifier)
        switch result {
        case let .success(beneficiary): return beneficiary
        case let .failure(error): throw error
        }
    }
}
