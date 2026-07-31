import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("InsuranceOnboardingViewModel")
struct InsuranceOnboardingViewModelTests {
    @Test
    func initialState_isLoadingAndEmpty() {
        let sut = InsuranceOnboardingViewModel(service: InsuranceServiceSpy(result: .success([])))

        #expect(sut.isLoading)
        #expect(sut.benefits.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_mapsBenefits() async {
        let service = InsuranceServiceSpy(result: .success([.init(image: "checkmark", text: "Coverage")]))
        let sut = InsuranceOnboardingViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.benefits.map(\.text) == ["Coverage"])
        #expect(sut.errorMessage == nil)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_clearsDataAndSetsError_whenServiceFails() async {
        let service = InsuranceServiceSpy(results: [
            .success([.init(image: "checkmark", text: "Coverage")]),
            .failure(URLError(.timedOut))
        ])
        let sut = InsuranceOnboardingViewModel(service: service)

        await sut.load()
        await sut.load()

        #expect(sut.benefits.isEmpty)
        #expect(sut.errorMessage == Strings.Common.errorSubmit)
        #expect(!sut.isLoading)
    }

    @Test
    func load_recoversFromPreviousError() async {
        let service = InsuranceServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success([.init(image: "checkmark", text: "Recovered")])
        ])
        let sut = InsuranceOnboardingViewModel(service: service)

        await sut.load()
        await sut.load()

        #expect(sut.errorMessage == nil)
        #expect(sut.benefits.map(\.text) == ["Recovered"])
        #expect(service.loadCalls == 2)
    }
}

private final class InsuranceServiceSpy: InsuranceOnboardingServicing {
    enum Result {
        case success([Benefits])
        case failure(Error)
    }

    private var results: [Result]
    private(set) var loadCalls = 0

    init(result: Result) { results = [result] }
    init(results: [Result]) { self.results = results }

    func loadBenefits() async throws -> [Benefits] {
        loadCalls += 1
        switch results.removeFirst() {
        case let .success(benefits): return benefits
        case let .failure(error): throw error
        }
    }
}
