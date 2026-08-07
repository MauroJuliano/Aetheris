import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("CardLockService")
struct CardLockServiceTests {
    @Test
    func fetchCardStatus_returnsMockPayloadForSelectedCard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = CardLockService(coreService: coreService)

        let card = try await sut.fetchCardStatus(cardId: CardMockIDs.infinite)

        #expect(card.id == CardMockIDs.infinite)
        #expect(card.isBlocked)
        #expect(card.style == .infinite)
        #expect(card.lastFourDigits == "7676")
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.infinite.uuidString)/lock-status",
                method: .get
            )
        ])
    }

    @Test
    func updateCardStatus_postsStatusAndCachesUpdatedCard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = CardLockService(coreService: coreService)

        let card = try await sut.fetchCardStatus(cardId: CardMockIDs.gold)
        let updatedCard = try await sut.updateCardStatus(
            cardId: card.id,
            isBlocked: true
        )
        let cachedCard = try await sut.fetchCardStatus(cardId: CardMockIDs.gold)

        #expect(!card.isBlocked)
        #expect(updatedCard.isBlocked)
        #expect(cachedCard.isBlocked)
        #expect(updatedCard.style == .gold)
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.gold.uuidString)/lock-status",
                method: .get
            ),
            .init(
                path: "/payments/cards/\(CardMockIDs.gold.uuidString)/lock-status",
                method: .post
            )
        ])
    }

    @Test
    func fetchCardStatus_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = CardLockService(coreService: coreService)

        do {
            _ = try await sut.fetchCardStatus(cardId: CardMockIDs.standard)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }
}
