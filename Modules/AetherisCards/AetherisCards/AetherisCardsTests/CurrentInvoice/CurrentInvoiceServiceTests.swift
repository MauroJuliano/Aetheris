import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("CurrentInvoiceService")
struct CurrentInvoiceServiceTests {
    @Test
    func loadInvoice_returnsMockPayloadForSelectedCard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = CurrentInvoiceService(coreService: coreService)

        let dashboard = try await sut.loadInvoice(cardId: CardMockIDs.standard)

        #expect(dashboard.invoice.cardId == CardMockIDs.standard)
        #expect(dashboard.invoice.status == .open)
        #expect(dashboard.invoice.amount == 350)
        #expect(dashboard.summaries.map(\.image) == ["applelogo", "ifoodlogo", "NetflixLogo"])
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.standard.uuidString)/current-invoice",
                method: .get
            )
        ])
    }

    @Test
    func loadInvoice_variesMockPayloadByCardIdentifier() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = CurrentInvoiceService(coreService: coreService)

        let goldDashboard = try await sut.loadInvoice(cardId: CardMockIDs.gold)
        let infiniteDashboard = try await sut.loadInvoice(cardId: CardMockIDs.infinite)

        #expect(goldDashboard.invoice.cardId == CardMockIDs.gold)
        #expect(goldDashboard.invoice.status == .closed)
        #expect(goldDashboard.invoice.amount == 1_148.70)
        #expect(infiniteDashboard.invoice.cardId == CardMockIDs.infinite)
        #expect(infiniteDashboard.invoice.status == .overdue)
        #expect(infiniteDashboard.invoice.amount == 2_780.40)
        #expect(goldDashboard.invoice.id != infiniteDashboard.invoice.id)
        #expect(coreService.calls == [
            .init(
                path: "/payments/cards/\(CardMockIDs.gold.uuidString)/current-invoice",
                method: .get
            ),
            .init(
                path: "/payments/cards/\(CardMockIDs.infinite.uuidString)/current-invoice",
                method: .get
            )
        ])
    }

    @Test
    func loadInvoice_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = CurrentInvoiceService(coreService: coreService)

        do {
            _ = try await sut.loadInvoice(cardId: CardMockIDs.standard)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }
}
