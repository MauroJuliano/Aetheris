import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("CardInsuranceViewModel")
struct CardInsuranceViewModelTests {
    @Test
    func initialState_isLoadingAndEmpty() {
        let sut = CardInsuranceViewModel(service: CardInsuranceServiceSpy(result: .success(.init(bullets: []))))

        #expect(sut.isLoading)
        #expect(sut.bullets.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_mapsBullets() async {
        let bullets = [CardInsuranceBullet(text: "Protected")]
        let service = CardInsuranceServiceSpy(result: .success(.init(bullets: bullets)))
        let sut = CardInsuranceViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.bullets.map(\.text) == ["Protected"])
        #expect(sut.errorMessage == nil)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_clearsDataAndSetsError_whenServiceFails() async {
        let service = CardInsuranceServiceSpy(results: [
            .success(.init(bullets: [.init(text: "Protected")])),
            .failure(URLError(.timedOut))
        ])
        let sut = CardInsuranceViewModel(service: service)

        await sut.load()
        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.bullets.isEmpty)
        #expect(sut.errorMessage == Strings.Common.errorSubmit)
        #expect(service.loadCalls == 2)
    }

    @Test
    func load_recoversFromPreviousError() async {
        let service = CardInsuranceServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success(.init(bullets: [.init(text: "Recovered")]))
        ])
        let sut = CardInsuranceViewModel(service: service)

        await sut.load()
        await sut.load()

        #expect(sut.errorMessage == nil)
        #expect(sut.bullets.map(\.text) == ["Recovered"])
    }
}

private final class CardInsuranceServiceSpy: CardInsuranceServicing {
    enum Result {
        case success(CardInsuranceResponse)
        case failure(Error)
    }

    private var results: [Result]
    private(set) var loadCalls = 0

    init(result: Result) { results = [result] }
    init(results: [Result]) { self.results = results }

    func loadBullets() async throws -> CardInsuranceResponse {
        loadCalls += 1
        switch results.removeFirst() {
        case let .success(response): return response
        case let .failure(error): throw error
        }
    }
}
