import Foundation
import Testing
@testable import Payments

@Suite("SendMoneyViewModel")
struct SendMoneyViewModelTests {
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
    func load_usesFallbackSession_whenServiceFails() async {
        let service = SendMoneyServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = SendMoneyViewModel(service: service)

        await sut.load()

        #expect(sut.session == .mock)
        #expect(sut.walletBalance == Decimal(SendMoneySession.mock.wallet.available))
    }

    @Test(arguments: [
        (Decimal(-1), false),
        (Decimal.zero, false),
        (Decimal(string: "0.01")!, true),
        (Decimal(1_000), true)
    ])
    func canContinue_validatesPositiveAmounts(amount: Decimal, expected: Bool) {
        let sut = SendMoneyViewModel(service: SendMoneyServiceSpy(result: .success(.mock)))

        #expect(sut.canContinue(currentAmount: amount) == expected)
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
    func continueTapped_mapsReceiptUsingLoadedSession() async throws {
        let service = SendMoneyServiceSpy(result: .success(makeSession(available: 500, accountName: "Savings")))
        let sut = SendMoneyViewModel(service: service)
        await sut.load()

        let receipt = try #require(sut.continueTapped(
            selectedBeneficiary: .fixture,
            currentAmount: 125,
            formattedAmount: "$ 125.00"
        ))

        #expect(receipt.amount == "$ 125.00")
        #expect(receipt.recipientName == "Melissa")
        #expect(receipt.recipientEmail == "melissa@example.com")
        #expect(receipt.accountName == "Savings")
        #expect(receipt.accountLastDigits == "9876")
        #expect(!receipt.date.isEmpty)
        #expect(receipt.referenceId.hasPrefix("TRX"))
    }

    private func makeSession(available: Double, accountName: String) -> SendMoneySession {
        SendMoneySession(
            wallet: .init(currency: "USD", balance: 1_000, available: available),
            account: .init(name: accountName, lastDigits: "9876"),
            limits: .init(currency: "USD", dailyLimit: 2_500, remainingDailyLimit: 2_000, singleTransferLimit: 1_000),
            fees: [],
            securityMessage: "Secure",
            processingMessage: "Processing",
            suggestedAmount: 100
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
}
