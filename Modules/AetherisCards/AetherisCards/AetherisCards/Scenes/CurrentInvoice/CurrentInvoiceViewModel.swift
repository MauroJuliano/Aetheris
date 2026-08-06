import Foundation

@MainActor
final class CurrentInvoiceViewModel: ObservableObject {
    @Published private(set) var invoice: CurrentInvoiceModel?
    @Published private(set) var summaries: [FinancialSummaryModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isStartingPayment = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var isInvoiceNoticeVisible = true

    private let cardId: UUID
    private let service: CurrentInvoiceServicing
    private var hasLoaded = false

    init(cardId: UUID, service: CurrentInvoiceServicing) {
        self.cardId = cardId
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

        defer {
            isLoading = false
        }

        do {
            let dashboard = try await service.loadInvoice(cardId: cardId)

            invoice = dashboard.invoice
            summaries = dashboard.summaries
            hasLoaded = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func dismissInvoiceNotice() {
        isInvoiceNoticeVisible = false
    }

    func setStartingPayment(_ isStarting: Bool) {
        isStartingPayment = isStarting
    }
}
