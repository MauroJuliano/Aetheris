import AetherisDesignSystem
import Foundation
import Testing
@testable import AetherisCards

@MainActor
@Suite("HomeCardViewModel")
struct HomeCardViewModelTests {
    @Test
    func initialState_isLoadingAndEmpty() {
        let sut = HomeCardViewModel(service: HomeCardServiceSpy(result: .success(.empty)))

        #expect(sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.cards.isEmpty)
        #expect(sut.cardDetails.isEmpty)
        #expect(sut.summaries.isEmpty)
        #expect(sut.quickActions.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_mapsDashboard() async {
        let dashboard = HomeCardDashboard(
            cards: CardsMock.creditCardMocks,
            cardDetails: [.fixture],
            summaries: [.fixture],
            quickActions: [.init(label: "Send", icon: "paperplane")]
        )
        let service = HomeCardServiceSpy(result: .success(dashboard))
        let sut = HomeCardViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.cards.count == 3)
        #expect(sut.cardDetails.map(\.cardId) == [CardMockIDs.standard])
        #expect(sut.summaries.map(\.title) == ["Transfer"])
        #expect(sut.quickActions.map(\.label) == ["Send"])
        #expect(sut.errorMessage == nil)
    }

    @Test
    func presentationAccessors_clampSelectionAndBuildCardSpecificContent() async {
        let dashboard = HomeCardDashboard(
            cards: CardsMock.creditCardMocks,
            cardDetails: [.fixture],
            summaries: [.fixture],
            quickActions: [
                .init(id: CardOptions.sendId, label: "Send", icon: "paperplane"),
                .init(id: CardOptions.requestId, label: "Request", icon: "arrow.down")
            ]
        )
        let sut = HomeCardViewModel(service: HomeCardServiceSpy(result: .success(dashboard)))

        await sut.load()

        #expect(sut.cardId(at: -1) == CardsMock.creditCardMocks[0].id)
        #expect(sut.cardId(at: 99) == CardsMock.creditCardMocks[2].id)
        #expect(sut.cardDetails(at: 0)?.cardId == CardMockIDs.standard)
        #expect(sut.summaries(at: 0).map(\.title) == ["Transfer"])
        #expect(sut.quickActions(at: 0).map(\.id) == [
            CardOptions.sendId,
            CardOptions.requestId,
            CardOptions.virtualCardId,
            CardOptions.cardLockId
        ])
        #expect(sut.quickActionItems(at: 0).map(\.id) == sut.quickActions(at: 0).map(\.id))
        #expect(sut.quickActionDestination(for: .virtualCard(), at: 0) == .virtualCard(CardsMock.creditCardMocks[0].id))
        #expect(sut.quickActionDestination(for: .cardLock(isBlocked: false), at: 0) == .cardLock(CardsMock.creditCardMocks[0].id))
        #expect(sut.quickActionDestination(
            for: .init(id: CardOptions.sendId, label: "Send", icon: "paperplane"),
            at: 0
        ) == .sendMoney)
        #expect(sut.quickActionDestination(
            for: .init(id: CardOptions.requestId, label: "Request", icon: "arrow.down"),
            at: 0
        ) == .requestMoney)
    }

    @Test
    func quickActionDestination_returnsCustomAction_andRequiresACard() async {
        let customAction = CardOptions(id: "custom", label: "Custom", icon: "sparkles")
        let populatedSUT = HomeCardViewModel(service: HomeCardServiceSpy(result: .success(.init(
            cards: CardsMock.creditCardMocks,
            cardDetails: [],
            summaries: [],
            quickActions: [customAction]
        ))))
        let emptySUT = HomeCardViewModel(service: HomeCardServiceSpy(result: .success(.empty)))

        await populatedSUT.load()
        await emptySUT.load()

        #expect(populatedSUT.quickActionDestination(for: customAction, at: 0) == .custom(customAction))
        #expect(emptySUT.quickActionDestination(for: customAction, at: 0) == nil)
    }

    @Test
    func loadIfNeeded_loadsOnlyOnceAcrossRepeatedAppearances() async {
        let dashboard = HomeCardDashboard(
            cards: CardsMock.creditCardMocks,
            cardDetails: [.fixture],
            summaries: [.fixture],
            quickActions: []
        )
        let service = HomeCardServiceSpy(result: .success(dashboard))
        let sut = HomeCardViewModel(service: service)

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.loadCalls == 1)
        #expect(!sut.isLoading)
        #expect(sut.cards.count == 3)
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
            .success(.init(cards: CardsMock.creditCardMocks, cardDetails: [], summaries: [], quickActions: []))
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
    static let empty = HomeCardDashboard(cards: [], cardDetails: [], summaries: [], quickActions: [])
}

private extension CardDetailsModel {
    static let fixture = CardDetailsModel(
        cardId: CardMockIDs.standard,
        availableLimit: 750,
        totalLimit: 1_000,
        currentInvoice: 250,
        invoiceStatus: "Open",
        dueDate: Date(),
        isBlocked: false
    )
}

private extension FinancialSummaryModel {
    static let fixture = FinancialSummaryModel(
        image: "sophie",
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
