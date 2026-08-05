import AetherisDesignSystem
import Testing
@testable import AetherisCards

@Suite("CardNavigationState")
struct CardNavigationStateTests {
    @Test
    func initialState_isAtRoot() {
        let sut = CardNavigationState()

        #expect(sut.isAtRoot)
        #expect(sut.path.isEmpty)
    }

    @Test
    func showTransactionHistory_preservesSelectedCardIdentifier() {
        var sut = CardNavigationState()

        sut.showTransactionHistory(cardID: CardMockIDs.gold)

        #expect(sut.path == [.transactionHistory(CardMockIDs.gold)])
        #expect(!sut.isAtRoot)
    }

    @Test
    func pop_returnsToRootAndIsSafeWhenAlreadyEmpty() {
        var sut = CardNavigationState()
        sut.showTransactionHistory(cardID: CardMockIDs.standard)

        sut.pop()
        sut.pop()

        #expect(sut.isAtRoot)
    }
}
