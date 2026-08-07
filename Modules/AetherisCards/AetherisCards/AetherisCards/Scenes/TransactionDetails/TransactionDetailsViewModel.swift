import Foundation

@MainActor
final class TransactionDetailsViewModel: ObservableObject {
    @Published private(set) var transaction: TransactionDetailsModel?
    @Published private(set) var isLoading = false
    @Published private(set) var isDownloadingReceipt = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var actionErrorMessage: String?

    private let transactionId: UUID
    private let service: any TransactionDetailsServicing
    private var hasLoaded = false

    init(transactionId: UUID, service: any TransactionDetailsServicing) {
        self.transactionId = transactionId
        self.service = service
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await load()
    }

    func load() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            transaction = try await service.fetchTransactionDetails(transactionId: transactionId)
            hasLoaded = true
        } catch {
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.TransactionDetails.unavailableTitle
            )
        }
    }

    func downloadReceipt() async -> URL? {
        guard !isDownloadingReceipt else { return nil }

        isDownloadingReceipt = true
        actionErrorMessage = nil

        defer { isDownloadingReceipt = false }

        do {
            return try await service.downloadReceipt(transactionId: transactionId)
        } catch {
            actionErrorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.TransactionDetails.errorTitle
            )
            return nil
        }
    }

    func updateNote(_ note: String?) async {
        do {
            transaction = try await service.updateNote(transactionId: transactionId, note: note)
        } catch {
            actionErrorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.TransactionDetails.errorTitle
            )
        }
    }

    func dismissActionError() {
        actionErrorMessage = nil
    }
}
