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
    func showTransactionDetails_preservesTransactionIdentifier() {
        var sut = CardNavigationState()

        sut.showTransactionDetails(transactionID: TransactionMockIDs.netflixSubscription)

        #expect(sut.path == [.transactionDetails(TransactionMockIDs.netflixSubscription)])
        #expect(!sut.isAtRoot)
    }

    @Test
    func showVirtualCard_preservesPhysicalCardIdentifier() {
        var sut = CardNavigationState()

        sut.showVirtualCard(physicalCardID: CardMockIDs.gold)

        #expect(sut.path == [.virtualCard(CardMockIDs.gold)])
        #expect(!sut.isAtRoot)
    }

    @Test
    func showCurrentInvoice_preservesCardIdentifier() {
        var sut = CardNavigationState()

        sut.showCurrentInvoice(cardID: CardMockIDs.gold)

        #expect(sut.path == [.currentInvoice(CardMockIDs.gold)])
        #expect(!sut.isAtRoot)
    }

    @Test
    func showCardLock_preservesCardIdentifier() {
        var sut = CardNavigationState()

        sut.showCardLock(cardID: CardMockIDs.gold)

        #expect(sut.path == [.cardLock(CardMockIDs.gold)])
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
