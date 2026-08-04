import Foundation
import Testing
@testable import Payments

@Suite("HomeNavigationState")
struct HomeNavigationStateTests {
    @Test
    func initialState_isAtRoot() {
        let sut = HomeNavigationState()

        #expect(sut.isAtRoot)
        #expect(sut.path.isEmpty)
    }

    @Test
    func push_preservesRouteOrder() {
        var sut = HomeNavigationState()

        sut.push(.card)
        sut.push(.notifications)
        sut.push(.allServices)

        #expect(sut.path == [.card, .notifications, .allServices])
        #expect(!sut.isAtRoot)
    }

    @Test
    func pop_removesOnlyLastRouteAndIsSafeAtRoot() {
        var sut = HomeNavigationState()
        sut.pop()
        #expect(sut.isAtRoot)

        sut.push(.card)
        sut.push(.notifications)
        sut.pop()

        #expect(sut.path == [.card])
    }

    @Test
    func replaceCurrent_replacesTopWithoutChangingPreviousRoutes() {
        var sut = HomeNavigationState()
        sut.push(.card)
        sut.push(.beneficiaryList)

        sut.replaceCurrent(with: .sendMoney)

        #expect(sut.path == [.card, .sendMoney])
    }

    @Test
    func replaceCurrent_pushesRouteWhenAtRoot() {
        var sut = HomeNavigationState()

        sut.replaceCurrent(with: .sendMoney)

        #expect(sut.path == [.sendMoney])
    }

    @Test
    func transferRoutes_preserveReceiptAcrossFlow() {
        let draft = TransferDraft.fixture
        let submission = TransferSubmission.fixture
        let receipt = TransferReceiptModel.fixture
        var sut = HomeNavigationState()

        sut.push(.sendMoney)
        sut.push(.sendMoneyPin(draft))
        sut.push(.sendMoneyProcessing(submission))
        sut.replaceCurrent(with: .sendMoneySuccess(receipt))

        #expect(sut.path == [
            .sendMoney,
            .sendMoneyPin(draft),
            .sendMoneySuccess(receipt)
        ])
    }

    @Test
    func returnToSendMoney_removesAuthenticationAndProcessingRoutes() {
        var sut = HomeNavigationState()
        sut.push(.sendMoney)
        sut.push(.sendMoneyPin(.fixture))
        sut.push(.sendMoneyProcessing(.fixture))

        sut.returnToSendMoney()

        #expect(sut.path == [.sendMoney])
    }

    @Test
    func reset_returnsToRootFromDeepLink() {
        var sut = HomeNavigationState()
        sut.push(.card)
        sut.push(.transactionHistory(UUID()))

        sut.reset()

        #expect(sut.isAtRoot)
    }
}

extension TransferReceiptModel {
    static let fixture = TransferReceiptModel(
        amount: "$ 10.00",
        recipientName: "Melissa",
        recipientEmail: "melissa@example.com",
        accountName: "Main Account",
        accountLastDigits: "1234",
        date: "Today",
        referenceId: "TRX123"
    )
}

extension TransferDraft {
    static let fixture = TransferDraft(
        amount: 10,
        formattedAmount: "$ 10.00",
        currency: "USD",
        beneficiaryName: "Melissa",
        beneficiaryIdentifier: "melissa@example.com",
        accountName: "Main Account",
        accountLastDigits: "1234"
    )
}

extension IdentityAuthorization {
    static let fixture = IdentityAuthorization(token: "authorization-token", expiresAt: "later")
}

extension TransferSubmission {
    static let fixture = TransferSubmission(
        draft: .fixture,
        authorization: .fixture,
        idempotencyKey: "idempotency-key"
    )
}

extension TransferReceiptResponse {
    static let fixture = TransferReceiptResponse(
        transactionId: "transaction-id",
        referenceId: "TRX-123",
        status: "completed",
        amount: 10,
        currency: "USD",
        recipientName: "Melissa",
        recipientIdentifier: "melissa@example.com",
        accountName: "Main Account",
        accountLastDigits: "1234",
        completedAt: "Today"
    )
}
