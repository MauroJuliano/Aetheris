import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisCards

@MainActor
@Suite("VirtualCardViewModel")
struct VirtualCardViewModelTests {
    @Test
    func loadIfNeeded_fetchesDashboardOnlyOnce() async {
        let dashboard = Self.makeDashboard()
        let service = VirtualCardServiceSpy(
            dashboard: .success(dashboard),
            updateCardStatus: .success(dashboard.virtualCard),
            generateNewCardNumber: .success(dashboard.virtualCard)
        )
        let sut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: service
        )

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.loadCalls == 1)
        #expect(sut.virtualCard?.physicalCardId == CardMockIDs.gold)
        #expect(sut.errorMessage == nil)
        #expect(!sut.isLoading)
    }

    @Test
    func load_setsErrorMessage_whenServiceFails() async {
        let service = VirtualCardServiceSpy(
            dashboard: .failure(URLError(.timedOut)),
            updateCardStatus: .failure(URLError(.timedOut)),
            generateNewCardNumber: .failure(URLError(.timedOut))
        )
        let sut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: service
        )

        await sut.load()

        #expect(sut.virtualCard == nil)
        #expect(sut.summaries.isEmpty)
        #expect(sut.errorMessage == Strings.VirtualCard.unavailableTitle)
        #expect(!sut.isLoading)
    }

    @Test
    func updateCardStatus_noOps_whenStateIsAlreadyCurrent() async {
        let dashboard = Self.makeDashboard(isActive: false)
        let service = VirtualCardServiceSpy(
            dashboard: .success(dashboard),
            updateCardStatus: .success(dashboard.virtualCard),
            generateNewCardNumber: .success(dashboard.virtualCard)
        )
        let sut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: service
        )

        await sut.load()
        await sut.updateCardStatus(isActive: false)

        #expect(service.updateCalls == 0)
        #expect(!sut.isUpdatingStatus)
    }

    @Test
    func updateCardStatus_updatesCard_andHandlesErrors() async {
        let dashboard = Self.makeDashboard(isActive: true)
        let updatedCard = VirtualCardModel(
            id: dashboard.virtualCard.id,
            physicalCardId: dashboard.virtualCard.physicalCardId,
            holderName: dashboard.virtualCard.holderName,
            cardNumber: dashboard.virtualCard.cardNumber,
            expirationDate: dashboard.virtualCard.expirationDate,
            securityCode: dashboard.virtualCard.securityCode,
            brand: dashboard.virtualCard.brand,
            style: dashboard.virtualCard.style,
            availableLimit: dashboard.virtualCard.availableLimit,
            totalLimit: dashboard.virtualCard.totalLimit,
            monthlyExpenses: dashboard.virtualCard.monthlyExpenses,
            isActive: false
        )
        let service = VirtualCardServiceSpy(
            dashboard: .success(dashboard),
            updateCardStatus: .success(updatedCard),
            generateNewCardNumber: .success(dashboard.virtualCard)
        )
        let sut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: service
        )

        await sut.load()
        await sut.updateCardStatus(isActive: false)

        #expect(service.updateCalls == 1)
        #expect(sut.virtualCard?.isActive == false)
        #expect(!sut.isUpdatingStatus)

        let failingService = VirtualCardServiceSpy(
            dashboard: .success(dashboard),
            updateCardStatus: .failure(URLError(.cannotConnectToHost)),
            generateNewCardNumber: .success(dashboard.virtualCard)
        )
        let failingSut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: failingService
        )

        await failingSut.load()
        await failingSut.updateCardStatus(isActive: false)

        #expect(failingSut.errorMessage == Strings.VirtualCard.unavailableTitle)
        #expect(!failingSut.isUpdatingStatus)
    }

    @Test
    func generateNewCardNumber_ignoresWhenCardIsMissing() async {
        let service = VirtualCardServiceSpy(
            dashboard: .success(Self.makeDashboard()),
            updateCardStatus: .success(Self.makeDashboard().virtualCard),
            generateNewCardNumber: .success(Self.makeDashboard().virtualCard)
        )
        let sut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: service
        )

        await sut.generateNewCardNumber()

        #expect(service.generateCalls == 0)
        #expect(!sut.isGeneratingNewNumber)
    }

    @Test
    func generateNewCardNumber_updatesCard_andHandlesErrors() async {
        let dashboard = Self.makeDashboard()
        let regenerated = VirtualCardModel(
            id: dashboard.virtualCard.id,
            physicalCardId: dashboard.virtualCard.physicalCardId,
            holderName: dashboard.virtualCard.holderName,
            cardNumber: "5329123412349999",
            expirationDate: dashboard.virtualCard.expirationDate,
            securityCode: "999",
            brand: dashboard.virtualCard.brand,
            style: dashboard.virtualCard.style,
            availableLimit: dashboard.virtualCard.availableLimit,
            totalLimit: dashboard.virtualCard.totalLimit,
            monthlyExpenses: dashboard.virtualCard.monthlyExpenses,
            isActive: true
        )
        let service = VirtualCardServiceSpy(
            dashboard: .success(dashboard),
            updateCardStatus: .success(dashboard.virtualCard),
            generateNewCardNumber: .success(regenerated)
        )
        let sut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: service
        )

        await sut.load()
        await sut.generateNewCardNumber()

        #expect(service.generateCalls == 1)
        #expect(sut.virtualCard?.cardNumber == regenerated.cardNumber)
        #expect(!sut.isGeneratingNewNumber)

        let failingService = VirtualCardServiceSpy(
            dashboard: .success(dashboard),
            updateCardStatus: .success(dashboard.virtualCard),
            generateNewCardNumber: .failure(URLError(.cannotFindHost))
        )
        let failingSut = VirtualCardViewModel(
            physicalCardId: CardMockIDs.gold,
            service: failingService
        )

        await failingSut.load()
        await failingSut.generateNewCardNumber()

        #expect(failingSut.errorMessage == Strings.VirtualCard.unavailableTitle)
        #expect(!failingSut.isGeneratingNewNumber)
    }

    private static func makeDashboard(isActive: Bool = true) -> VirtualCardDashboard {
        let card = VirtualCardModel(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111110001")!,
            physicalCardId: CardMockIDs.gold,
            holderName: "Marina Souza",
            cardNumber: "5329123412347373",
            expirationDate: "09/29",
            securityCode: "123",
            brand: .mastercard,
            style: .gold,
            availableLimit: 6_500,
            totalLimit: 8_000,
            monthlyExpenses: 1_500,
            isActive: isActive
        )

        return VirtualCardDashboard(
            virtualCard: card,
            summaries: [
                FinancialSummaryModel(
                    cardId: CardMockIDs.gold,
                    image: "NetflixLogo",
                    title: "Netflix",
                    description: "Subscription",
                    value: "-$ 20.00",
                    tag: .expense,
                    date: Date()
                )
            ]
        )
    }
}

private final class VirtualCardServiceSpy: VirtualCardServiceProtocol {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }

    let dashboard: Result<VirtualCardDashboard>
    let updateCardStatus: Result<VirtualCardModel>
    let generateNewCardNumber: Result<VirtualCardModel>

    private(set) var loadCalls = 0
    private(set) var updateCalls = 0
    private(set) var generateCalls = 0

    init(
        dashboard: Result<VirtualCardDashboard>,
        updateCardStatus: Result<VirtualCardModel>,
        generateNewCardNumber: Result<VirtualCardModel>
    ) {
        self.dashboard = dashboard
        self.updateCardStatus = updateCardStatus
        self.generateNewCardNumber = generateNewCardNumber
    }

    func loadDashboard(physicalCardId: UUID) async throws -> VirtualCardDashboard {
        loadCalls += 1

        switch dashboard {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }

    func fetchVirtualCard(physicalCardId: UUID) async throws -> VirtualCardModel {
        let dashboard = try await loadDashboard(physicalCardId: physicalCardId)
        return dashboard.virtualCard
    }

    func fetchSummaries(physicalCardId: UUID) async throws -> [FinancialSummaryModel] {
        let dashboard = try await loadDashboard(physicalCardId: physicalCardId)
        return dashboard.summaries
    }

    func updateCardStatus(cardId: UUID, isActive: Bool) async throws -> VirtualCardModel {
        updateCalls += 1

        switch updateCardStatus {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }

    func generateNewCardNumber(cardId: UUID) async throws -> VirtualCardModel {
        generateCalls += 1

        switch generateNewCardNumber {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
