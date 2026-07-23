import Core
import Foundation
import Testing
@testable import Payments

@Suite("HomeAppService")
struct HomeAppServiceTests {
    @Test
    func loadCards_returnsMockDashboard() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = HomeAppService(coreService: coreService)

        let cards = try await sut.loadCards()

        #expect(cards.count == 6)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/home/cards", method: .get)
        ])

        let contents = cards.compactMap(content(from:))
        let creditCards = contents.compactMap { content -> Any? in
            guard case "creditCard" = caseName(of: content) else { return nil }
            return associatedModel(from: content)
        }
        let infoCards = contents.compactMap { content -> Any? in
            guard case "info" = caseName(of: content) else { return nil }
            return associatedModel(from: content)
        }

        #expect(creditCards.count == 2)
        #expect(infoCards.count == 4)
        #expect(stringValue(creditCards[0], "number") == "**** **** **** **21")
        #expect(stringValue(creditCards[0], "name") == Strings.HomeApp.mockCardOwnerOne)
        #expect(stringValue(creditCards[0], "brand") == Strings.HomeApp.mockVisa)
        #expect(stringValue(infoCards[0], "headline") == Strings.HomeApp.rewardsHeadline)
        #expect(stringValue(infoCards[1], "headline") == Strings.HomeApp.monthlySpendingHeadline)
    }

    @Test
    func loadCards_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = HomeAppService(coreService: coreService)

        do {
            _ = try await sut.loadCards()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    private func content(from card: Any) -> Any? {
        Mirror(reflecting: card).children.first(where: { $0.label == "content" })?.value
    }

    private func caseName(of content: Any) -> String? {
        Mirror(reflecting: content).children.first?.label
    }

    private func associatedModel(from content: Any) -> Any? {
        Mirror(reflecting: content).children.first?.value
    }

    private func stringValue(_ value: Any, _ field: String) -> String? {
        Mirror(reflecting: value).children.first(where: { $0.label == field })?.value as? String
    }
}
