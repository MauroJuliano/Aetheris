import Core
import Foundation

protocol TransactionDetailsServicing {
    func fetchTransactionDetails(transactionId: UUID) async throws -> TransactionDetailsModel
    func downloadReceipt(transactionId: UUID) async throws -> URL
    func updateNote(transactionId: UUID, note: String?) async throws -> TransactionDetailsModel
}

final class TransactionDetailsService: TransactionDetailsServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func fetchTransactionDetails(transactionId: UUID) async throws -> TransactionDetailsModel {
        try await coreService.execute(TransactionDetailsEndpoint.details(transactionId: transactionId))
    }

    func downloadReceipt(transactionId: UUID) async throws -> URL {
        let response: TransactionReceiptResponse = try await coreService.execute(
            TransactionDetailsEndpoint.receipt(transactionId: transactionId)
        )
        return response.receiptURL
    }

    func updateNote(transactionId: UUID, note: String?) async throws -> TransactionDetailsModel {
        let request = TransactionNoteUpdateRequest(note: note)
        return try await coreService.execute(
            TransactionDetailsEndpoint.updateNote(transactionId: transactionId, request: request)
        )
    }
}
