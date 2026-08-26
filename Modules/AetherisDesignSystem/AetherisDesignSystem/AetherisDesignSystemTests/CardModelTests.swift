import Foundation
import Testing
@testable import AetherisDesignSystem

@Suite("CardModel")
struct CardModelTests {
    @Test
    func creditCardModel_defaultsToStandardStyle() {
        let model = CreditCardModel(
            number: "1234",
            validDate: "08/29",
            name: "Blake Lehmann",
            brand: "VISA"
        )

        #expect(model.style == .standard)
    }

    @Test
    func card_roundTripsThroughCodablePreservingStyleAndContent() throws {
        let model = CreditCardModel(
            number: "1234 5678 9012 3456",
            validDate: "08/29",
            name: "Blake Lehmann",
            brand: "VISA",
            style: .gold
        )
        let card = Card(content: .creditCard(model))

        let data = try JSONEncoder().encode(card)
        let decoded = try JSONDecoder().decode(Card.self, from: data)

        #expect(decoded.id == card.id)
        #expect(decoded == card)
    }

    @Test
    func creditCardStyle_exposesExpectedThemeShape() {
        let styles: [CreditCardStyle] = [
            .standard,
            .black,
            .platinum,
            .gold,
            .aurora,
            .infinite
        ]

        styles.forEach { style in
            let theme = style.theme
            #expect(theme.gradient.count == 2)
            #expect(theme.glow.count == 2)
        }
    }
}
