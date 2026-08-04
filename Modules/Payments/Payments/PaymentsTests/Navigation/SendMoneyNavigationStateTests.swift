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
        let draft = TransferDraft.fixture
        let submission = TransferSubmission.fixture
        let receipt = TransferReceiptModel.fixture
        var sut = SendMoneyNavigationState()
        sut.push(.pin(draft))
        sut.push(.processing(submission))

        sut.replaceCurrent(with: .success(receipt))

        #expect(sut.path == [.pin(draft), .success(receipt)])
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
        sut.push(.pin(.fixture))
        sut.push(.processing(.fixture))
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
