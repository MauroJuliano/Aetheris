import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisCards

@MainActor
@Suite("CurrentInvoiceViewModel")
struct CurrentInvoiceViewModelTests {
    @Test
    func loadIfNeeded_fetchesInvoiceOnlyOnce() async {
        let service = CurrentInvoiceServiceSpy(result: .success(Self.makeDashboard()))
        let sut = CurrentInvoiceViewModel(cardId: CardMockIDs.standard, service: service)

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.loadCalls == 1)
        #expect(sut.invoice?.cardId == CardMockIDs.standard)
        #expect(sut.errorMessage == nil)
        #expect(!sut.isLoading)
    }

    @Test
    func load_setsErrorMessage_whenServiceFails() async {
        let service = CurrentInvoiceServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = CurrentInvoiceViewModel(cardId: CardMockIDs.standard, service: service)

        await sut.load()

        #expect(sut.invoice == nil)
        #expect(sut.summaries.isEmpty)
        #expect(sut.errorMessage == Strings.CurrentInvoice.unavailableTitle)
        #expect(!sut.isLoading)
    }

    @Test
    func dismissInvoiceNotice_andSetStartingPayment_updateFlags() {
        let sut = CurrentInvoiceViewModel(
            cardId: CardMockIDs.standard,
            service: CurrentInvoiceServiceSpy(result: .success(Self.makeDashboard()))
        )

        #expect(sut.isInvoiceNoticeVisible)
        #expect(!sut.isStartingPayment)

        sut.dismissInvoiceNotice()
        sut.setStartingPayment(true)

        #expect(!sut.isInvoiceNoticeVisible)
        #expect(sut.isStartingPayment)
    }

    private static func makeDashboard() -> CurrentInvoiceDashboard {
        CurrentInvoiceDashboard(
            invoice: CurrentInvoiceModel(
                id: UUID(uuidString: "11111111-1111-1111-1111-111111110901")!,
                cardId: CardMockIDs.standard,
                amount: 350,
                status: .open,
                dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
                bestPurchaseDate: Calendar.current.date(byAdding: .day, value: 15, to: Date()) ?? Date(),
                totalLimit: 5_000,
                availableLimit: 2_750,
                usedLimit: 2_250,
                details: .init(
                    purchasesSubtotal: 318.50,
                    otherCharges: 31.50,
                    discountsAndCredits: 0,
                    total: 350
                ),
                spendingSummary: .init(
                    totalSpent: 2_250,
                    installmentPurchases: 1_200,
                    oneTimePurchases: 1_050
                )
            ),
            summaries: [
                FinancialSummaryModel(
                    cardId: CardMockIDs.standard,
                    image: "applelogo",
                    title: "Apple",
                    description: "Subscription",
                    value: "-$ 9.00",
                    tag: .expense,
                    date: Date()
                )
            ]
        )
    }
}

private final class CurrentInvoiceServiceSpy: CurrentInvoiceServicing {
    enum Result {
        case success(CurrentInvoiceDashboard)
        case failure(Error)
    }

    private let result: Result
    private(set) var loadCalls = 0

    init(result: Result) {
        self.result = result
    }

    func loadInvoice(cardId: UUID) async throws -> CurrentInvoiceDashboard {
        loadCalls += 1

        switch result {
        case let .success(dashboard):
            return dashboard
        case let .failure(error):
            throw error
        }
    }
}
