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

    var displayedTransaction: TransactionDetailsModel? {
        transaction ?? (isLoading ? .loadingPlaceholder : nil)
    }

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

    func performAction(
        _ action: TransactionAction,
        onShareTap: @escaping (UUID) -> Void,
        onDownloadTap: @escaping (UUID) -> Void,
        onAddNoteTap: @escaping (UUID) -> Void,
        onReportIssueTap: @escaping (UUID) -> Void
    ) {
        switch action {
        case .share:
            onShareTap(transactionId)
        case .download:
            Task {
                guard await downloadReceipt() != nil else { return }
                onDownloadTap(transactionId)
            }
        case .addNote:
            onAddNoteTap(transactionId)
        case .reportIssue:
            onReportIssueTap(transactionId)
        }
    }

    func dismissActionError() {
        actionErrorMessage = nil
    }
}

private extension TransactionDetailsModel {
    static var loadingPlaceholder: TransactionDetailsModel {
        TransactionDetailsModel(
            id: UUID(),
            title: Strings.TransactionDetails.title,
            subtitle: nil,
            amount: 0,
            currencyCode: "USD",
            kind: .purchase,
            status: .pending,
            date: .now,
            transactionCode: "",
            note: nil,
            imageName: nil,
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: nil,
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: []
        )
    }
}
