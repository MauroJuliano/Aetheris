import Foundation
import Core
import Testing
@testable import AetherisHome

@Suite("AllServicesService")
struct AllServicesServiceTests {
    @Test
    func loadServices_returnsMockPayloadFromEndpoint() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = AllServicesService(coreService: coreService)

        let items = try await sut.loadServices()

        #expect(items.count == 5)
        #expect(items.map(\.title) == [
            Strings.AllServices.transferMoney,
            Strings.AllServices.manageBeneficiaries,
            Strings.AllServices.cardCenter,
            Strings.AllServices.notifications,
            Strings.AllServices.reports
        ])
        #expect(items.map(\.icon) == [
            "arrow.right.arrow.left",
            "person.2.fill",
            "creditcard.fill",
            "bell.fill",
            "chart.bar.fill"
        ])
        #expect(items.map(\.theme) == [.primary, .info, .warning, .primary, .info])
        #expect(items.map(\.route) == [.transfer, .beneficiaries, .cards, .notifications, .reports])
        #expect(Set(items.map(\.id)).count == items.count)
        #expect(coreService.calls == [
            .init(path: "/payments/services", method: .get)
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
            #expect(coreService.calls.count == 1)
        }
    }
}
