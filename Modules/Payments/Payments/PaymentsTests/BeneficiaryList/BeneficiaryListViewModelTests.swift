import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("BeneficiaryListViewModel")
struct BeneficiaryListViewModelTests {
    @Test
    func initialState_usesRecentRecipientsAndStartsLoading() {
        let recent = [Beneficiary.fixture(name: "Recent")]
        let store = RecentRecipientsStoreSpy(result: recent)
        let sut = BeneficiaryListViewModel(
            service: BeneficiaryListServiceSpy(result: .failure(URLError(.timedOut))),
            recentRecipientsStore: store
        )

        #expect(sut.isLoading)
        #expect(sut.beneficiaries.map(\.name) == ["Recent"])
        #expect(store.calls.count == 1)
        #expect(store.calls[0].limit == 4)
    }

    @Test
    func load_usesServicePayloadAsFallbackForRecentRecipients() async {
        let response = BeneficiaryListResponse(beneficiaries: [.fixture(name: "Remote")])
        let store = RecentRecipientsStoreSpy(results: [
            [.fixture(name: "Initial")],
            [.fixture(name: "Merged")]
        ])
        let service = BeneficiaryListServiceSpy(result: .success(response))
        let sut = BeneficiaryListViewModel(service: service, recentRecipientsStore: store)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.beneficiaries.map(\.name) == ["Merged"])
        #expect(store.calls.last?.fallback.map(\.name) == ["Remote"])
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_usesDefaultFallback_whenServiceFails() async {
        let store = RecentRecipientsStoreSpy(results: [
            [.fixture(name: "Initial")],
            [.fixture(name: "Fallback")]
        ])
        let service = BeneficiaryListServiceSpy(result: .failure(URLError(.notConnectedToInternet)))
        let sut = BeneficiaryListViewModel(service: service, recentRecipientsStore: store)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.beneficiaries.map(\.name) == ["Fallback"])
        #expect(store.calls.last?.fallback.count == BeneficiaryFixtures.defaults.count)
    }
}

private extension Beneficiary {
    static func fixture(name: String) -> Beneficiary {
        Beneficiary(name: name, pixKey: "\(name.lowercased())@example.com", image: "avatar", hasDivider: true)
    }
}

@MainActor
private final class RecentRecipientsStoreSpy: RecentRecipientsProviding {
    struct Call {
        let limit: Int
        let fallback: [Beneficiary]
    }

    private var results: [[Beneficiary]]
    private(set) var calls: [Call] = []

    init(result: [Beneficiary]) { results = [result] }
    init(results: [[Beneficiary]]) { self.results = results }

    func beneficiaries(limit: Int, fallback: [Beneficiary]) -> [Beneficiary] {
        calls.append(.init(limit: limit, fallback: fallback))
        return results.removeFirst()
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
