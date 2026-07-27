import Core
import Foundation
import Testing
@testable import Payments

@Suite("HomeCardService")
struct HomeCardServiceTests {
    @Test
    func loadDashboard_andQuickActions_returnMockData() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = HomeCardService(coreService: coreService)

        let dashboard = try await sut.loadDashboard()
        let quickActions = try await sut.loadQuickActions()

        #expect(dashboard.cards.count == 3)
        #expect(dashboard.summaries.count == 4)
        #expect(dashboard.summaries.map(\.tag) == [.transfer, .income, .expense, .expense])
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/home-card/dashboard", method: .get),
            .init(path: "https://api.aetheris.app/payments/home-card/dashboard", method: .get)
        ])

        #expect(quickActions.map(\.label) == [
            "Send",
            "Request",
            "Pay",
            "Top up"
        ])
        #expect(quickActions.map(\.icon) == [
            "paperplane.fill",
            "arrow.down",
            "creditcard.fill",
            "plus"
        ])
    }

    @Test
    func loadDashboard_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = HomeCardService(coreService: coreService)

        do {
            _ = try await sut.loadDashboard()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
