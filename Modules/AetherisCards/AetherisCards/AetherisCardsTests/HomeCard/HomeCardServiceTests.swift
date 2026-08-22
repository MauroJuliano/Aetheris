import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("HomeCardService")
struct HomeCardServiceTests {
    @Test
    func loadDashboard_returnsStructuredMockData() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = HomeCardService(coreService: coreService)

        let dashboard = try await sut.loadDashboard()

        #expect(dashboard.cards.count == 3)
        #expect(dashboard.summaries.count == 11)
        #expect(dashboard.summaries.map(\.type) == [
            .transfer, .income, .subscription, .subscription, .purchase,
            .transfer, .subscription, .transfer, .income, .subscription, .purchase
        ])
        #expect(dashboard.summaries.first?.counterparty == "Sophie Keller")
        #expect(dashboard.summaries.first?.amount == -250)
        #expect(coreService.calls == [
            .init(path: "/payments/home-card/dashboard", method: .get),
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
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadDashboard_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"cards":[]}"#.utf8)
        let sut = HomeCardService(coreService: coreService)

        do {
            _ = try await sut.loadDashboard()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
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
            #expect(coreService.calls.count == 1)
        }
    }
}
