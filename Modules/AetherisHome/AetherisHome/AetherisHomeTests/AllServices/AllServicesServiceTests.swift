import Foundation
import Testing
@testable import AetherisHome

@Suite("AllServicesService")
struct AllServicesServiceTests {
    @Test
    func loadServices_returnsLocalItems() async {
        let sut = AllServicesService()

        let items = await sut.loadServices()

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
    }
}
