import AetherisDesignSystem
import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("HomeCardViewModel")
struct HomeCardViewModelTests {
    @Test
    func initialState_isLoadingAndEmpty() {
        let sut = HomeCardViewModel(service: HomeCardServiceSpy(result: .success(.empty)))

        #expect(sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.cards.isEmpty)
        #expect(sut.summaries.isEmpty)
        #expect(sut.quickActions.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_mapsDashboard() async {
        let dashboard = HomeCardDashboard(
            cards: CardsMock.creditCardMocks,
            summaries: [.fixture],
            quickActions: [.init(label: "Send", icon: "paperplane")]
        )
        let service = HomeCardServiceSpy(result: .success(dashboard))
        let sut = HomeCardViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.cards.count == 3)
        #expect(sut.summaries.map(\.title) == ["Transfer"])
        #expect(sut.quickActions.map(\.label) == ["Send"])
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_marksDashboardEmpty_whenCardsAndSummariesAreEmpty() async {
        let sut = HomeCardViewModel(service: HomeCardServiceSpy(result: .success(.empty)))

        await sut.load()

        #expect(sut.isEmpty)
        #expect(!sut.isLoading)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_setsErrorAndRecoversOnRetry() async {
        let service = HomeCardServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success(.init(cards: CardsMock.creditCardMocks, summaries: [], quickActions: []))
        ])
        let sut = HomeCardViewModel(service: service)

        await sut.load()
        #expect(sut.errorMessage != nil)

        await sut.load()

        #expect(sut.errorMessage == nil)
        #expect(sut.cards.count == 3)
        #expect(!sut.isLoading)
        #expect(service.loadCalls == 2)
    }
}

private extension HomeCardDashboard {
    static let empty = HomeCardDashboard(cards: [], summaries: [], quickActions: [])
}

private extension FinancialSummaryModel {
    static let fixture = FinancialSummaryModel(
        image: "melissa",
        title: "Transfer",
        description: "Sent",
        value: "-$ 10.00",
        tag: .transfer,
        date: Date()
    )
}

private final class HomeCardServiceSpy: HomeCardServicing {
    enum Result { case success(HomeCardDashboard), failure(Error) }
    private var results: [Result]
    private(set) var loadCalls = 0

    init(result: Result) { results = [result] }
    init(results: [Result]) { self.results = results }

    func loadDashboard() async throws -> HomeCardDashboard {
        loadCalls += 1
        switch results.removeFirst() {
        case let .success(dashboard): return dashboard
        case let .failure(error): throw error
        }
    }
}
