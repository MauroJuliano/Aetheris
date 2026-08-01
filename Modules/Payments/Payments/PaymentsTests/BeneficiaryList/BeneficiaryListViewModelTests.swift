import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("BeneficiaryListViewModel")
struct BeneficiaryListViewModelTests {
    @Test
    func initialState_usesLimitedDefaultBeneficiariesAndStartsLoading() {
        let sut = BeneficiaryListViewModel(
            service: BeneficiaryListServiceSpy(result: .failure(URLError(.timedOut)))
        )

        #expect(sut.isLoading)
        #expect(sut.beneficiaries.count == min(4, BeneficiaryFixtures.defaults.count))
        #expect(sut.beneficiaries.map(\.name) == Array(BeneficiaryFixtures.defaults.prefix(4)).map(\.name))
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
    func load_usesDefaultFallback_whenServiceFails() async {
        let service = BeneficiaryListServiceSpy(result: .failure(URLError(.notConnectedToInternet)))
        let sut = BeneficiaryListViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.beneficiaries.map(\.name) == Array(BeneficiaryFixtures.defaults.prefix(4)).map(\.name))
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
