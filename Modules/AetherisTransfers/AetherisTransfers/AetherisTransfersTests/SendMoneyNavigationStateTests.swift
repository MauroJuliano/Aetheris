import Testing
@testable import AetherisTransfers

@Suite("SendMoneyNavigationState")
struct SendMoneyNavigationStateTests {
    @Test
    func beneficiarySelection_returnsToPreviousRoute() {
        var sut = SendMoneyNavigationState()
        sut.push(.beneficiaryList(.transferSelection))

        sut.pop()

        #expect(sut.isAtRoot)
    }

    @Test
    func beneficiaryList_preservesSelectionContext() {
        var sut = SendMoneyNavigationState()

        sut.push(.beneficiaryList(.transferSelection))
        sut.push(.beneficiaryList(.detailsNavigation))

        #expect(sut.path == [
            .beneficiaryList(.transferSelection),
            .beneficiaryList(.detailsNavigation)
        ])
    }

    @Test
    func beneficiaryDetails_preservesBeneficiaryIdentifier() {
        let beneficiaryId = BeneficiaryFixtures.defaults[1].id
        var sut = SendMoneyNavigationState()

        sut.push(.beneficiaryDetails(beneficiaryId))

        #expect(sut.path == [.beneficiaryDetails(beneficiaryId)])
        #expect(!sut.isAtRoot)
    }

    @Test
    func requestMoney_preservesBeneficiaryIdentifier() {
        let beneficiary = BeneficiaryFixtures.defaults[1]
        let contact = RequestContactModel(
            id: beneficiary.id,
            name: beneficiary.name,
            contactInformation: beneficiary.pixKey,
            imageName: beneficiary.image
        )
        var sut = SendMoneyNavigationState()

        sut.push(.requestMoney(contact))

        #expect(sut.path == [.requestMoney(contact)])
        #expect(!sut.isAtRoot)
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
