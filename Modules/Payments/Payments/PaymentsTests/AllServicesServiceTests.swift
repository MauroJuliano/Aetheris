import Core
import Foundation
import Testing
@testable import Payments

@Suite("AllServicesService")
struct AllServicesServiceTests {
    @Test
    func loadServices_returnsMockItems() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = AllServicesService(coreService: coreService)

        let items = try await sut.loadServices()

        #expect(items.count == 6)
        #expect(items.map(\.title) == [
            Strings.AllServices.transferMoney,
            Strings.AllServices.manageBeneficiaries,
            Strings.AllServices.cardCenter,
            Strings.AllServices.notifications,
            Strings.AllServices.insurance,
            Strings.AllServices.reports
        ])
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/all-services", method: .get)
        ])
    }

    @Test
    func loadServices_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = AllServicesService(coreService: coreService)

        do {
            _ = try await sut.loadServices()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    @Test
    func loadServices_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.timedOut)
        let sut = AllServicesService(coreService: coreService)

        do {
            _ = try await sut.loadServices()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .timedOut)
        }
    }
}
