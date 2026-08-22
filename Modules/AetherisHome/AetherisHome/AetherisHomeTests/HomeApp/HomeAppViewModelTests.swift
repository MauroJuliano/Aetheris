import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisHome

@MainActor
@Suite("HomeAppViewModel")
struct HomeAppViewModelTests {
    private let locale = Locale(identifier: "pt_BR")

    @Test
    func initialState_isLoadingAndHasNoDashboardData() {
        let sut = makeSUT(result: .success(.mock))

        #expect(sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.errorMessage == nil)
        #expect(sut.cards.isEmpty)
        #expect(sut.recentRecipients.isEmpty)
        #expect(sut.spendingThisMonth == nil)
        #expect(sut.unreadCount == 0)
        #expect(!sut.hasUnreadNotifications)
    }

    @Test
    func spendingAnalyticsCardModel_usesMockBeforeLoading() {
        let sut = makeSUT(result: .success(.mock))

        #expect(sut.spendingAnalyticsCardModel.title == Strings.SpendingChart.title)
        #expect(sut.spendingAnalyticsCardModel.totalTitle == "$ 2.428,00")
        #expect(sut.spendingAnalyticsCardModel.changeTitle == "+8%")
        #expect(sut.spendingAnalyticsCardModel.comparisonTitle == Strings.SpendingChart.comparison)
        #expect(sut.spendingAnalyticsCardModel.categories.count == 4)
    }

    @Test
    func quickActionItems_areDefinedLocallyBeforeLoading() {
        let sut = makeSUT(result: .success(.mock))

        #expect(sut.quickActionItems.count == 3)
        #expect(sut.recipientItems.isEmpty)
        #expect(sut.recipientItems.map(\.id) == sut.recentRecipients.map(\.id))
        #expect(sut.quickActionItems[0].title == Strings.QuickActions.sendTitle)
        #expect(sut.quickActionItems[1].title == Strings.QuickActions.requestTitle)
        #expect(sut.quickActionItems[2].title == Strings.QuickActions.moreTitle)
    }

    @Test
    func load_mapsDashboardIntoViewState() async {
        let service = HomeAppServiceSpy(result: .success(.mock))
        let sut = makeSUT(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.errorMessage == nil)
        #expect(sut.userFirstName == "Blake")
        #expect(sut.balanceText == "$ 13.553,00")
        #expect(sut.isBalanceVisible)
        #expect(sut.cards.count == 3)
        #expect(sut.recentRecipients.count == 6)
        #expect(sut.spendingThisMonth?.categories.count == 4)
        #expect(sut.unreadCount == 3)
        #expect(sut.hasUnreadNotifications)
        #expect(service.loadCalls == 1)
        #expect(sut.spendingAnalyticsCardModel.title == Strings.SpendingChart.title)
        #expect(sut.spendingAnalyticsCardModel.categories.count == 4)
        #expect(sut.quickActionItems.count == 3)
    }

    @Test
    func selectedCardId_atIndexClampsToAvailableCards() async {
        let sut = makeSUT(result: .success(makeDashboard(cards: HomeAppDashboard.mock.cards)))

        await sut.load()

        #expect(sut.selectedCardId(at: -1) == HomeAppDashboard.mock.cards[0].id)
        #expect(sut.selectedCardId(at: 1) == HomeAppDashboard.mock.cards[1].id)
        #expect(sut.selectedCardId(at: 99) == HomeAppDashboard.mock.cards[2].id)
    }

    @Test
    func loadIfNeeded_loadsOnlyOnceAcrossRepeatedAppearances() async {
        let service = HomeAppServiceSpy(result: .success(.mock))
        let sut = makeSUT(service: service)

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.loadCalls == 1)
        #expect(!sut.isLoading)
        #expect(sut.cards.count == 3)
    }

    @Test
    func load_mapsRecipientFieldsAndPreservesValidIdentifier() async throws {
        let recipientID = try #require(UUID(uuidString: "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"))
        let dashboard = makeDashboard(
            recipients: [
                .init(
                    id: recipientID.uuidString,
                    name: "Taylor",
                    pixKey: "taylor@example.com",
                    avatar: "taylor"
                )
            ]
        )
        let sut = makeSUT(result: .success(dashboard))

        await sut.load()

        let recipient = try #require(sut.recentRecipients.first)
        #expect(recipient.id == recipientID)
        #expect(recipient.name == "Taylor")
        #expect(recipient.pixKey == "taylor@example.com")
        #expect(recipient.image == "taylor")
        #expect(recipient.hasDivider)
    }

    @Test
    func load_marksDashboardAsEmpty_whenThereAreNoCards() async {
        let dashboard = makeDashboard(cards: [])
        let sut = makeSUT(result: .success(dashboard))

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.isEmpty)
        #expect(sut.errorMessage == nil)
        #expect(sut.cards.isEmpty)
    }

    @Test
    func load_usesMaskedBalance_whenDashboardRequestsMasking() async {
        let dashboard = makeDashboard(masked: true)
        let sut = makeSUT(result: .success(dashboard))

        await sut.load()

        #expect(!sut.isBalanceVisible)
        #expect(sut.balanceText == "$ 13.553,00")
    }

    @Test
    func load_formatsBalancesUsingInjectedLocale() async {
        let cases: [(currency: String, amount: Double, expected: String)] = [
            ("USD", 0, "$ 0,00"),
            ("USD", -1_234.50, "$ -1.234,50"),
            ("USD", 1_234_567.89, "$ 1.234.567,89"),
            ("USD", 1.999, "$ 2,00"),
            ("EUR", 42.50, "EUR 42,50")
        ]

        for testCase in cases {
            let dashboard = makeDashboard(
                currency: testCase.currency,
                amount: testCase.amount
            )
            let sut = makeSUT(result: .success(dashboard))

            await sut.load()

            #expect(sut.balanceText == testCase.expected)
        }
    }

    @Test
    func load_keepsLoadingStateWhileServiceIsPending() async {
        let service = DeferredHomeAppService()
        let sut = makeSUT(service: service)

        let load = Task { await sut.load() }
        await service.waitForCallCount(1)

        #expect(sut.isLoading)
        #expect(sut.errorMessage == nil)

        await service.succeed(.mock, call: 0)
        await load.value

        #expect(!sut.isLoading)
    }

    @Test
    func load_setsErrorState_whenServiceFails() async {
        let service = HomeAppServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = makeSUT(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.errorMessage == Strings.HomeApp.cardsLoadFailed)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_recoversFromPreviousError_whenRetrySucceeds() async {
        let service = HomeAppServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success(makeDashboard(firstName: "Recovered"))
        ])
        let sut = makeSUT(service: service)

        await sut.load()
        #expect(sut.errorMessage != nil)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.errorMessage == nil)
        #expect(sut.userFirstName == "Recovered")
        #expect(service.loadCalls == 2)
    }

    @Test
    func load_ignoresOlderResponse_whenNewerRequestFinishesFirst() async {
        let service = DeferredHomeAppService()
        let sut = makeSUT(service: service)

        let olderLoad = Task { await sut.load() }
        await service.waitForCallCount(1)
        let newerLoad = Task { await sut.load() }
        await service.waitForCallCount(2)

        await service.succeed(makeDashboard(firstName: "Newest"), call: 1)
        await newerLoad.value
        await service.succeed(makeDashboard(firstName: "Outdated"), call: 0)
        await olderLoad.value

        let loadCalls = await service.loadCalls
        #expect(sut.userFirstName == "Newest")
        #expect(!sut.isLoading)
        #expect(loadCalls == 2)
    }

    private func makeSUT(result: HomeAppServiceSpy.Result) -> HomeAppViewModel {
        makeSUT(service: HomeAppServiceSpy(result: result))
    }

    private func makeSUT(service: any HomeAppServicing) -> HomeAppViewModel {
        HomeAppViewModel(service: service, locale: locale)
    }

    private func makeDashboard(
        firstName: String = "Blake",
        currency: String = "USD",
        amount: Double = 13_553,
        masked: Bool = false,
        cards: [AetherisDesignSystem.Card] = HomeAppDashboard.mock.cards,
        recipients: [HomeAppDashboard.RecentRecipient] = []
    ) -> HomeAppDashboard {
        HomeAppDashboard(
            user: .init(firstName: firstName, lastName: "Brown"),
            balance: .init(currency: currency, amount: amount, masked: masked),
            cards: cards,
            recentRecipients: recipients,
            spendingThisMonth: .init(
                total: 0,
                changePercent: 0,
                categories: [],
                series: []
            ),
            notifications: .init(unreadCount: 0)
        )
    }
}

private final class HomeAppServiceSpy: HomeAppServicing {
    enum Result {
        case success(HomeAppDashboard)
        case failure(Error)
    }

    private var results: [Result]
    private(set) var loadCalls = 0

    init(result: Result) {
        results = [result]
    }

    init(results: [Result]) {
        self.results = results
    }

    func loadDashboard() async throws -> HomeAppDashboard {
        loadCalls += 1
        let result = results.removeFirst()

        switch result {
        case let .success(dashboard):
            return dashboard
        case let .failure(error):
            throw error
        }
    }
}

private actor DeferredHomeAppService: HomeAppServicing {
    typealias Continuation = CheckedContinuation<HomeAppDashboard, Error>

    private var continuations: [Continuation?] = []
    private(set) var loadCalls = 0

    func loadDashboard() async throws -> HomeAppDashboard {
        return try await withCheckedThrowingContinuation { continuation in
            continuations.append(continuation)
            loadCalls += 1
        }
    }

    func waitForCallCount(_ expectedCount: Int) async {
        while loadCalls < expectedCount {
            await Task.yield()
        }
    }

    func succeed(_ dashboard: HomeAppDashboard, call index: Int) {
        continuations[index]?.resume(returning: dashboard)
        continuations[index] = nil
    }
}
