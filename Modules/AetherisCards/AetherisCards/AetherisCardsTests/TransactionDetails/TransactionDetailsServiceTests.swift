import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("TransactionDetailsService")
struct TransactionDetailsServiceTests {
    @Test
    func fetchTransactionDetails_returnsSubscriptionMockForNetflixTransaction() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionDetailsService(coreService: coreService)

        let transaction = try await sut.fetchTransactionDetails(
            transactionId: TransactionMockIDs.netflixSubscription
        )

        #expect(transaction.id == TransactionMockIDs.netflixSubscription)
        #expect(transaction.title == "Netflix")
        #expect(transaction.kind == .subscription)
        #expect(transaction.subscriptionDetails?.billingFrequency == .monthly)
        #expect(transaction.subscriptionDetails?.paymentHistory.count == 3)
        #expect(coreService.calls == [
            .init(
                path: "/payments/transactions/\(TransactionMockIDs.netflixSubscription.uuidString)",
                method: .get
            )
        ])
    }

    @Test
    func fetchTransactionDetails_variesSectionModelByTransactionIdentifier() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionDetailsService(coreService: coreService)

        let incoming = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.ameliaPayment)
        let transfer = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.sophieTransfer)
        let purchase = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.ifoodPurchase)
        let invoicePayment = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.invoicePayment)

        #expect(incoming.kind == .incomingPayment)
        #expect(incoming.incomingPaymentDetails != nil)
        #expect(transfer.kind == .outgoingTransfer)
        #expect(transfer.transferDetails != nil)
        #expect(purchase.kind == .purchase)
        #expect(purchase.merchantDetails != nil)
        #expect(invoicePayment.kind == .invoicePayment)
        #expect(invoicePayment.invoicePaymentDetails != nil)
    }

    @Test
    func downloadReceipt_returnsReceiptURLAndCallsReceiptEndpoint() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionDetailsService(coreService: coreService)

        let url = try await sut.downloadReceipt(transactionId: TransactionMockIDs.netflixSubscription)

        #expect(url.lastPathComponent == "transaction-\(TransactionMockIDs.netflixSubscription.uuidString)-receipt.pdf")
        #expect(coreService.calls == [
            .init(
                path: "/payments/transactions/\(TransactionMockIDs.netflixSubscription.uuidString)/receipt",
                method: .get
            )
        ])
    }

    @Test
    func updateNote_postsNoteAndReturnsUpdatedTransaction() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionDetailsService(coreService: coreService)

        let transaction = try await sut.updateNote(
            transactionId: TransactionMockIDs.netflixSubscription,
            note: "Business expense"
        )

        #expect(transaction.note == "Business expense")
        #expect(coreService.calls == [
            .init(
                path: "/payments/transactions/\(TransactionMockIDs.netflixSubscription.uuidString)/note",
                method: .post
            )
        ])
    }

    @Test
    func fetchTransactionDetails_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = TransactionDetailsService(coreService: coreService)

        do {
            _ = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.netflixSubscription)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }
}
