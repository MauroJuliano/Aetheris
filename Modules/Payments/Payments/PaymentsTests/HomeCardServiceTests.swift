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

        #expect(dashboard.cards.count == 3)
        #expect(dashboard.summaries.count == 4)
        #expect(dashboard.quickActions.count == 4)
        #expect(dashboard.summaries.map(\.tag) == [.transfer, .income, .expense, .expense])
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/home-card/dashboard", method: .get),
        ])
        #expect(dashboard.quickActions.map(\.label) == [
            "Send",
            "Request",
            "Pay",
            "Top up"
        ])
        #expect(dashboard.quickActions.map(\.icon) == [
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

    @Test
    func loadDashboard_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.timedOut)
        let sut = HomeCardService(coreService: coreService)

        do {
            _ = try await sut.loadDashboard()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .timedOut)
        }
    }
}
