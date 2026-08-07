import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("TransactionDetailsViewModel")
@MainActor
struct TransactionDetailsViewModelTests {
    @Test
    func loadIfNeeded_fetchesTransactionOnlyOnce() async {
        let service = TransactionDetailsServiceSpy(
            transaction: TransactionDetailsMockStore.transaction(
                for: TransactionMockIDs.netflixSubscription
            )
        )
        let sut = TransactionDetailsViewModel(
            transactionId: TransactionMockIDs.netflixSubscription,
            service: service
        )

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.fetchTransactionDetailsCallCount == 1)
        #expect(sut.transaction?.kind == .subscription)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_setsErrorMessageWhenServiceFails() async {
        let service = TransactionDetailsServiceSpy(error: CoreServiceError.invalidData)
        let sut = TransactionDetailsViewModel(
            transactionId: TransactionMockIDs.netflixSubscription,
            service: service
        )

        await sut.load()

        #expect(sut.transaction == nil)
        #expect(sut.errorMessage == Strings.TransactionDetails.unavailableTitle)
    }

    @Test
    func downloadReceipt_returnsURLAndTogglesActionState() async {
        let receiptURL = URL(fileURLWithPath: "/tmp/receipt.pdf")
        let service = TransactionDetailsServiceSpy(receiptURL: receiptURL)
        let sut = TransactionDetailsViewModel(
            transactionId: TransactionMockIDs.netflixSubscription,
            service: service
        )

        let result = await sut.downloadReceipt()

        #expect(result == receiptURL)
        #expect(!sut.isDownloadingReceipt)
        #expect(service.downloadReceiptCallCount == 1)
        #expect(sut.actionErrorMessage == nil)
    }

    @Test
    func updateNote_replacesLoadedTransaction() async {
        let service = TransactionDetailsServiceSpy(
            transaction: TransactionDetailsMockStore.transaction(
                for: TransactionMockIDs.netflixSubscription
            )
        )
        let sut = TransactionDetailsViewModel(
            transactionId: TransactionMockIDs.netflixSubscription,
            service: service
        )

        await sut.updateNote("Shared account")

        #expect(sut.transaction?.note == "Shared account")
        #expect(service.updateNoteCallCount == 1)
    }
}

private final class TransactionDetailsServiceSpy: TransactionDetailsServicing {
    private let transaction: TransactionDetailsModel
    private let receiptURL: URL
    private let error: Error?

    private(set) var fetchTransactionDetailsCallCount = 0
    private(set) var downloadReceiptCallCount = 0
    private(set) var updateNoteCallCount = 0

    init(
        transaction: TransactionDetailsModel = TransactionDetailsMockStore.transaction(
            for: TransactionMockIDs.netflixSubscription
        ),
        receiptURL: URL = URL(fileURLWithPath: "/tmp/transaction-receipt.pdf"),
        error: Error? = nil
    ) {
        self.transaction = transaction
        self.receiptURL = receiptURL
        self.error = error
    }

    func fetchTransactionDetails(transactionId: UUID) async throws -> TransactionDetailsModel {
        fetchTransactionDetailsCallCount += 1
        if let error { throw error }
        return transaction
    }

    func downloadReceipt(transactionId: UUID) async throws -> URL {
        downloadReceiptCallCount += 1
        if let error { throw error }
        return receiptURL
    }

    func updateNote(transactionId: UUID, note: String?) async throws -> TransactionDetailsModel {
        updateNoteCallCount += 1
        if let error { throw error }
        return TransactionDetailsMockStore.transaction(for: transactionId, note: note)
    }
}
