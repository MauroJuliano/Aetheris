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
        let ameliaTransfer = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.ameliaTransfer)
        let transfer = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.sophieTransfer)
        let purchase = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.ifoodPurchase)
        let invoicePayment = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.invoicePayment)

        #expect(incoming.kind == .incomingPayment)
        #expect(incoming.incomingPaymentDetails != nil)
        #expect(ameliaTransfer.kind == .outgoingTransfer)
        #expect(ameliaTransfer.transferDetails?.recipientName == "Amelia Thompson")
        #expect(transfer.kind == .outgoingTransfer)
        #expect(transfer.transferDetails != nil)
        #expect(purchase.kind == .purchase)
        #expect(purchase.merchantDetails != nil)
        #expect(invoicePayment.kind == .invoicePayment)
        #expect(invoicePayment.invoicePaymentDetails != nil)
    }

    @Test
    func fetchTransactionDetails_preservesBeneficiaryPaymentMessage() async throws {
        let sut = TransactionDetailsService(coreService: CoreServiceTestDouble())

        let transaction = try await sut.fetchTransactionDetails(
            transactionId: TransactionMockIDs.beneficiaryPayment
        )

        #expect(transaction.kind == .incomingPayment)
        #expect(transaction.amount == 75)
        #expect(transaction.note == Strings.Mock.thanksForCollaboration)
    }

    @Test
    func fetchTransactionDetails_mapsBeneficiaryTransfersInsteadOfUsingFallback() async throws {
        let sut = TransactionDetailsService(coreService: CoreServiceTestDouble())

        let dinner = try await sut.fetchTransactionDetails(
            transactionId: TransactionMockIDs.beneficiaryDinnerTransfer
        )
        let concert = try await sut.fetchTransactionDetails(
            transactionId: TransactionMockIDs.beneficiaryConcertTransfer
        )

        #expect(dinner.kind == .outgoingTransfer)
        #expect(dinner.amount == 50)
        #expect(dinner.transferDetails?.recipientName == "Sophie Keller")
        #expect(dinner.note == Strings.Mock.dinnerWithSophie)
        #expect(concert.kind == .outgoingTransfer)
        #expect(concert.amount == 200)
        #expect(concert.note == Strings.Mock.concertTicket)
    }

    @Test
    func fetchTransactionDetails_mapsEveryCardActivityAlias() async throws {
        let sut = TransactionDetailsService(coreService: CoreServiceTestDouble())

        let infinitePayment = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.infinitePayment)
        let infiniteTransfer = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.infiniteTransfer)
        let goldTransfer = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.goldTransfer)
        let goldSubscription = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.goldSubscription)
        let blackApple = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.blackAppleSubscription)
        let blackIfood = try await sut.fetchTransactionDetails(transactionId: TransactionMockIDs.blackIfoodPurchase)

        #expect(infinitePayment.kind == .incomingPayment)
        #expect(infinitePayment.amount == 125)
        #expect(infiniteTransfer.kind == .outgoingTransfer)
        #expect(infiniteTransfer.amount == 70)
        #expect(goldTransfer.kind == .outgoingTransfer)
        #expect(goldTransfer.amount == 480)
        #expect(goldSubscription.kind == .subscription)
        #expect(blackApple.kind == .subscription)
        #expect(blackIfood.kind == .purchase)
    }

    @Test
    func fetchTransactionDetails_usesNeutralFallback_forUnknownIdentifiers() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionDetailsService(coreService: coreService)
        let unknownId = UUID(uuidString: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF")!

        let transaction = try await sut.fetchTransactionDetails(transactionId: unknownId)

        #expect(transaction.id == unknownId)
        #expect(transaction.title == "Transaction")
        #expect(transaction.kind == .purchase)
        #expect(transaction.imageName == nil)
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
