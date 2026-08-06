import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("VirtualCardService")
struct VirtualCardServiceTests {
    @Test
    func loadDashboard_returnsMockPayloadForSelectedPhysicalCard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = VirtualCardService(coreService: coreService)

        let dashboard = try await sut.loadDashboard(physicalCardId: CardMockIDs.gold)

        #expect(dashboard.virtualCard.physicalCardId == CardMockIDs.gold)
        #expect(dashboard.virtualCard.style == .gold)
        #expect(dashboard.virtualCard.brand == .mastercard)
        #expect(dashboard.summaries.count == 3)
        #expect(dashboard.summaries.map(\.image) == ["NetflixLogo", "applelogo", "melissa"])
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.gold.uuidString)/virtual-card",
                method: .get
            )
        ])
    }

    @Test
    func updateCardStatus_postsStatusAndReturnsUpdatedCard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = VirtualCardService(coreService: coreService)
        let dashboard = try await sut.loadDashboard(physicalCardId: CardMockIDs.gold)

        let updatedCard = try await sut.updateCardStatus(
            cardId: dashboard.virtualCard.id,
            isActive: false
        )

        #expect(!updatedCard.isActive)
        #expect(updatedCard.physicalCardId == CardMockIDs.gold)
        #expect(updatedCard.style == .gold)
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.gold.uuidString)/virtual-card",
                method: .get
            ),
            .init(
                path: "/payments/virtual-cards/\(dashboard.virtualCard.id.uuidString)/status",
                method: .post
            )
        ])
    }

    @Test
    func generateNewCardNumber_postsNumberRegenerationAndKeepsCardVariant() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = VirtualCardService(coreService: coreService)
        let dashboard = try await sut.loadDashboard(physicalCardId: CardMockIDs.infinite)

        let regeneratedCard = try await sut.generateNewCardNumber(
            cardId: dashboard.virtualCard.id
        )

        #expect(regeneratedCard.cardNumber != dashboard.virtualCard.cardNumber)
        #expect(regeneratedCard.securityCode != dashboard.virtualCard.securityCode)
        #expect(regeneratedCard.style == .infinite)
        #expect(regeneratedCard.physicalCardId == CardMockIDs.infinite)
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.infinite.uuidString)/virtual-card",
                method: .get
            ),
            .init(
                path: "/payments/virtual-cards/\(dashboard.virtualCard.id.uuidString)/number",
                method: .post
            )
        ])
    }

    @Test
    func loadDashboard_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = VirtualCardService(coreService: coreService)

        do {
            _ = try await sut.loadDashboard(physicalCardId: CardMockIDs.standard)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }
}
