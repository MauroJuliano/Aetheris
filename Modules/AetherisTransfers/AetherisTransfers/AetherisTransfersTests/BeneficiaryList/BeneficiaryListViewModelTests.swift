import Foundation
import Testing
@testable import AetherisTransfers

@MainActor
@Suite("BeneficiaryListViewModel")
struct BeneficiaryListViewModelTests {
    @Test
    func initialState_startsLoadingAndEmpty() {
        let sut = BeneficiaryListViewModel(
            service: BeneficiaryListServiceSpy(result: .failure(URLError(.timedOut)))
        )

        #expect(sut.isLoading)
        #expect(sut.beneficiaries.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_usesAtMostFourBeneficiariesFromService() async {
        let remote = (1...5).map { Beneficiary.fixture(name: "Remote \($0)") }
        let service = BeneficiaryListServiceSpy(result: .success(.init(beneficiaries: remote)))
        let sut = BeneficiaryListViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.beneficiaries.map(\.name) == ["Remote 1", "Remote 2", "Remote 3", "Remote 4"])
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_setsErrorAndKeepsBeneficiariesEmpty_whenServiceFails() async {
        let service = BeneficiaryListServiceSpy(result: .failure(URLError(.notConnectedToInternet)))
        let sut = BeneficiaryListViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.beneficiaries.isEmpty)
        #expect(sut.errorMessage == Strings.BeneficiaryList.loadFailed)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_acceptsEmptyRemoteList() async {
        let service = BeneficiaryListServiceSpy(result: .success(.init(beneficiaries: [])))
        let sut = BeneficiaryListViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.beneficiaries.isEmpty)
    }

    @Test
    func presentationCollections_filterAndGroupBeneficiaries() async {
        let remote = [
            Beneficiary.fixture(name: "Bruno"),
            Beneficiary.fixture(name: "Alice"),
            Beneficiary.fixture(name: "Amanda")
        ]
        let sut = BeneficiaryListViewModel(
            service: BeneficiaryListServiceSpy(result: .success(.init(beneficiaries: remote)))
        )

        await sut.load()

        #expect(sut.recentBeneficiaries.map(\.name) == ["Bruno", "Alice", "Amanda"])
        #expect(sut.filteredBeneficiaries(query: "man").map(\.name) == ["Amanda"])
        #expect(sut.sections(query: "a").map(\.letter) == ["A"])
        #expect(sut.sections(query: "a")[0].beneficiaries.map(\.name) == ["Alice", "Amanda"])
    }
}

private extension Beneficiary {
    static func fixture(name: String) -> Beneficiary {
        Beneficiary(name: name, pixKey: "\(name.lowercased())@example.com", image: "avatar", hasDivider: true)
    }
}

private final class BeneficiaryListServiceSpy: BeneficiaryListServicing {
    enum Result { case success(BeneficiaryListResponse), failure(Error) }
    let result: Result
    private(set) var loadCalls = 0

    init(result: Result) { self.result = result }

    func loadBeneficiaryList() async throws -> BeneficiaryListResponse {
        loadCalls += 1
        switch result {
        case let .success(response): return response
        case let .failure(error): throw error
        }
    }
}
