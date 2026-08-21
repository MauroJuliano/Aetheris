import AetherisDesignSystem
import Core
import Foundation

protocol VirtualCardServiceProtocol {
    func loadDashboard(physicalCardId: UUID) async throws -> VirtualCardDashboard
    func fetchVirtualCard(physicalCardId: UUID) async throws -> VirtualCardModel
    func fetchSummaries(physicalCardId: UUID) async throws -> [FinancialSummaryModel]
    func updateCardStatus(cardId: UUID, isActive: Bool) async throws -> VirtualCardModel
    func generateNewCardNumber(cardId: UUID) async throws -> VirtualCardModel
}

struct VirtualCardDashboard: Codable {
    let virtualCard: VirtualCardModel
    let summaries: [FinancialSummaryModel]
}

final class VirtualCardService: VirtualCardServiceProtocol {
    private let coreService: any HasCoreService
    private let cache = VirtualCardServiceCache()

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadDashboard(physicalCardId: UUID) async throws -> VirtualCardDashboard {
        let dashboard: VirtualCardDashboard = try await coreService.execute(
            VirtualCardEndpoint.dashboard(physicalCardId: physicalCardId)
        )

        await cache.store(dashboard.virtualCard)

        return dashboard
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
        let currentCard = try await currentCard(for: cardId)
        let updatedCard = currentCard.updating(isActive: isActive)
        let request = VirtualCardStatusUpdateRequest(isActive: isActive)

        let card: VirtualCardModel = try await coreService.execute(
            VirtualCardEndpoint.updateStatus(card: updatedCard, request: request)
        )
        await cache.store(card)

        return card
    }

    func generateNewCardNumber(cardId: UUID) async throws -> VirtualCardModel {
        let currentCard = try await currentCard(for: cardId)

        let card: VirtualCardModel = try await coreService.execute(
            VirtualCardEndpoint.generateNewNumber(card: currentCard.regeneratingNumber())
        )
        await cache.store(card)

        return card
    }

    private func currentCard(for cardId: UUID) async throws -> VirtualCardModel {
        if let cachedCard = await cache.card(id: cardId) {
            return cachedCard
        }

        let physicalCardId = await cache.physicalCardId(for: cardId) ?? cardId
        return try await fetchVirtualCard(physicalCardId: physicalCardId)
    }
}

private actor VirtualCardServiceCache {
    private var cachedCards: [UUID: VirtualCardModel] = [:]
    private var physicalCardIdsByVirtualCardId: [UUID: UUID] = [:]

    func card(id: UUID) -> VirtualCardModel? {
        cachedCards[id]
    }

    func physicalCardId(for cardId: UUID) -> UUID? {
        physicalCardIdsByVirtualCardId[cardId]
    }

    func store(_ card: VirtualCardModel) {
        cachedCards[card.id] = card
        physicalCardIdsByVirtualCardId[card.id] = card.physicalCardId
    }
}
