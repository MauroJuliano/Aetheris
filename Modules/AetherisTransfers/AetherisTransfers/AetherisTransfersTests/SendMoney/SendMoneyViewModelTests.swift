import Foundation
import Testing
@testable import AetherisTransfers

@Suite("SendMoneyViewModel")
struct SendMoneyViewModelTests {
    @Test
    func initialState_isLoadingUntilSessionRequestFinishes() {
        let sut = SendMoneyViewModel(service: SendMoneyServiceSpy(result: .success(.mock)))

        #expect(sut.isLoading)
        #expect(sut.session == nil)
    }

    @Test
    func load_setsSession_whenServiceSucceeds() async {
        let session = makeSession(available: 750, accountName: "Savings")
        let service = SendMoneyServiceSpy(result: .success(session))
        let sut = SendMoneyViewModel(service: service)

        await sut.load()

        #expect(sut.session == session)
        #expect(sut.walletBalance == 750)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_exposesErrorWithoutUsingFallbackSession_whenServiceFails() async {
        let service = SendMoneyServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = SendMoneyViewModel(service: service)

        await sut.load()

        #expect(sut.session == nil)
        #expect(sut.walletBalance == 0)
        #expect(sut.errorMessage != nil)
    }

    @Test(arguments: [
        (Decimal(-1), false),
        (Decimal.zero, false),
        (Decimal(string: "0.01")!, true),
        (Decimal(1_000), true),
        (Decimal(1_000.01), false)
    ])
    func canContinue_validatesPositiveAmountsAndAvailableBalance(amount: Decimal, expected: Bool) async {
        let sut = SendMoneyViewModel(service: SendMoneyServiceSpy(result: .success(.mock)))
        await sut.load()

        #expect(
            sut.canContinue(
                selectedBeneficiary: .fixture,
                currentAmount: amount
            ) == expected
        )
    }

    @Test
    func canContinue_requiresSelectedBeneficiary() async {
        let sut = SendMoneyViewModel(service: SendMoneyServiceSpy(result: .success(.mock)))
        await sut.load()

        #expect(
            !sut.canContinue(
                selectedBeneficiary: nil,
                currentAmount: 50
            )
        )
    }

    @Test
    func continueTapped_returnsNil_whenAmountIsNotPositive() {
        let service = SendMoneyServiceSpy(result: .success(.mock))
        let sut = SendMoneyViewModel(service: service)

        let receipt = sut.continueTapped(
            selectedBeneficiary: .fixture,
            currentAmount: 0,
            formattedAmount: "$ 0.00"
        )

        #expect(receipt == nil)
    }

    @Test
    func continueTapped_mapsDraftUsingLoadedSession() async throws {
        let service = SendMoneyServiceSpy(result: .success(makeSession(available: 500, accountName: "Savings")))
        let sut = SendMoneyViewModel(service: service)
        await sut.load()

        let draft = try #require(sut.continueTapped(
            selectedBeneficiary: .fixture,
            currentAmount: 125,
            formattedAmount: "$ 125.00"
        ))

        #expect(draft.amount == 125)
        #expect(draft.formattedAmount == "$ 125.00")
        #expect(draft.beneficiaryName == "Melissa")
        #expect(draft.beneficiaryIdentifier == "melissa@example.com")
        #expect(draft.accountName == "Savings")
        #expect(draft.accountLastDigits == "9876")
    }

    private func makeSession(available: Double, accountName: String) -> SendMoneySession {
        SendMoneySession(
            wallet: .init(currency: "USD", balance: 1_000, available: available),
            account: .init(name: accountName, lastDigits: "9876")
        )
    }
}

private extension Beneficiary {
    static let fixture = Beneficiary(
        name: "Melissa",
        pixKey: "melissa@example.com",
        image: "melissa",
        hasDivider: true
    )
}

private final class SendMoneyServiceSpy: SendMoneyServicing {
    enum Result { case success(SendMoneySession), failure(Error) }
    let result: Result
    private(set) var loadCalls = 0

    init(result: Result) { self.result = result }

    func loadSession() async throws -> SendMoneySession {
        loadCalls += 1
        switch result {
        case let .success(session): return session
        case let .failure(error): throw error
        }
    }

    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse {
        .fixture
    }
}
