import Testing
@testable import Payments

@Suite("SendMoneyNavigationState")
struct SendMoneyNavigationStateTests {
    @Test
    func beneficiarySelection_returnsToPreviousRoute() {
        var sut = SendMoneyNavigationState()
        sut.push(.beneficiaryList)

        sut.pop()

        #expect(sut.isAtRoot)
    }

    @Test
    func successfulTransfer_replacesProcessingWithSuccess() {
        let receipt = TransferReceiptModel.fixture
        var sut = SendMoneyNavigationState()
        sut.push(.pin(receipt))
        sut.push(.processing(receipt))

        sut.replaceCurrent(with: .success(receipt))

        #expect(sut.path == [.pin(receipt), .success(receipt)])
    }

    @Test
    func replaceCurrent_pushesWhenPathIsEmpty() {
        let receipt = TransferReceiptModel.fixture
        var sut = SendMoneyNavigationState()

        sut.replaceCurrent(with: .success(receipt))

        #expect(sut.path == [.success(receipt)])
    }

    @Test
    func newTransfer_resetsNavigationToRoot() {
        let receipt = TransferReceiptModel.fixture
        var sut = SendMoneyNavigationState()
        sut.push(.pin(receipt))
        sut.push(.processing(receipt))
        sut.replaceCurrent(with: .success(receipt))

        sut.reset()

        #expect(sut.isAtRoot)
    }

    @Test
    func pop_isSafeAtRoot() {
        var sut = SendMoneyNavigationState()

        sut.pop()

        #expect(sut.isAtRoot)
    }
}
