import Core
import Foundation
import Testing
@testable import Payments

@Suite("HomeAppService")
struct HomeAppServiceTests {
    @Test
    func loadDashboard_returnsMockDashboard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = HomeAppService(coreService: coreService)

        let dashboard = try await sut.loadDashboard()

        #expect(dashboard.user.firstName == "Blake")
        #expect(dashboard.user.lastName == "Brown")
        #expect(dashboard.balance.amount == 13_553.00)
        #expect(dashboard.balance.masked == false)
        #expect(dashboard.cards.count == 3)
        #expect(dashboard.recentRecipients.count == 4)
        #expect(dashboard.quickActions.count == 4)
        #expect(dashboard.spendingThisMonth.categories.count == 4)
        #expect(dashboard.notifications.unreadCount == 3)
        #expect(coreService.calls == [
            .init(path: "/payments/home/dashboard", method: .get)
        ])
    }

    @Test
    func loadDashboard_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = HomeAppService(coreService: coreService)

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
        coreService.responseData = Data(#"{"user":{"firstName":"Incomplete"}}"#.utf8)
        let sut = HomeAppService(coreService: coreService)

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
        coreService.error = URLError(.notConnectedToInternet)
        let sut = HomeAppService(coreService: coreService)

        do {
            _ = try await sut.loadDashboard()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .notConnectedToInternet)
            #expect(coreService.calls.count == 1)
        }
    }
}
