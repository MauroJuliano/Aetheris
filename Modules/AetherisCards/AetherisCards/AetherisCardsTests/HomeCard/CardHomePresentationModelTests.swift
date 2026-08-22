import AetherisDesignSystem
import Foundation
import Testing
@testable import AetherisCards

@MainActor
@Suite("CardHomePresentationModel")
struct CardHomePresentationModelTests {
    @Test
    func initialSelection_isAppliedOnlyOnce() {
        let sut = CardHomePresentationModel()
        let cards = CardsMock.creditCardMocks

        sut.applyInitialSelection(cardID: cards[1].id, cards: cards)
        sut.applyInitialSelection(cardID: cards[2].id, cards: cards)

        #expect(sut.selectedCardIndex == 1)
    }

    @Test
    func requestedSelection_reportsWhetherItWasApplied() {
        let sut = CardHomePresentationModel()
        let cards = CardsMock.creditCardMocks

        let didApplyKnownCard = sut.applyRequestedSelection(
            cardID: cards[2].id,
            cards: cards
        )
        let didApplyUnknownCard = sut.applyRequestedSelection(
            cardID: UUID(),
            cards: cards
        )

        #expect(didApplyKnownCard)
        #expect(!didApplyUnknownCard)
        #expect(sut.selectedCardIndex == 2)
    }
}
