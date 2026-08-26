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

    @Test
    func performAction_routesCallbacksAndUsesReceiptDownloadForDownloadAction() async {
        let service = TransactionDetailsServiceSpy(
            transaction: TransactionDetailsMockStore.transaction(
                for: TransactionMockIDs.netflixSubscription
            )
        )
        let sut = TransactionDetailsViewModel(
            transactionId: TransactionMockIDs.netflixSubscription,
            service: service
        )

        var shareCalls = 0
        var downloadCalls = 0
        var addNoteCalls = 0
        var reportCalls = 0

        sut.performAction(
            .share,
            onShareTap: { _ in shareCalls += 1 },
            onDownloadTap: { _ in downloadCalls += 1 },
            onAddNoteTap: { _ in addNoteCalls += 1 },
            onReportIssueTap: { _ in reportCalls += 1 }
        )

        sut.performAction(
            .addNote,
            onShareTap: { _ in shareCalls += 1 },
            onDownloadTap: { _ in downloadCalls += 1 },
            onAddNoteTap: { _ in addNoteCalls += 1 },
            onReportIssueTap: { _ in reportCalls += 1 }
        )

        sut.performAction(
            .reportIssue,
            onShareTap: { _ in shareCalls += 1 },
            onDownloadTap: { _ in downloadCalls += 1 },
            onAddNoteTap: { _ in addNoteCalls += 1 },
            onReportIssueTap: { _ in reportCalls += 1 }
        )

        sut.performAction(
            .download,
            onShareTap: { _ in shareCalls += 1 },
            onDownloadTap: { _ in downloadCalls += 1 },
            onAddNoteTap: { _ in addNoteCalls += 1 },
            onReportIssueTap: { _ in reportCalls += 1 }
        )

        try? await Task.sleep(nanoseconds: 50_000_000)

        #expect(shareCalls == 1)
        #expect(addNoteCalls == 1)
        #expect(reportCalls == 1)
        #expect(downloadCalls == 1)
        #expect(service.downloadReceiptCallCount == 1)
    }

    @Test
    func sectionKind_matchesTransactionKind() {
        let transaction = TransactionDetailsMockStore.transaction(
            for: TransactionMockIDs.appleSubscription
        )

        #expect(transaction.sectionKind == .subscription)
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
