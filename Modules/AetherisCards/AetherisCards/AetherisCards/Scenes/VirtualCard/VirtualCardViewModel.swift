import Foundation

@MainActor
final class VirtualCardViewModel: ObservableObject {
    @Published private(set) var virtualCard: VirtualCardModel?
    @Published private(set) var summaries: [FinancialSummaryModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isUpdatingStatus = false
    @Published private(set) var isGeneratingNewNumber = false
    @Published private(set) var errorMessage: String?

    private var hasLoaded = false
    private let physicalCardId: UUID
    private let service: VirtualCardServiceProtocol

    init(physicalCardId: UUID, service: VirtualCardServiceProtocol) {
        self.physicalCardId = physicalCardId
        self.service = service
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await load()
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            async let cardRequest = service.fetchVirtualCard(physicalCardId: physicalCardId)
            async let summariesRequest = service.fetchSummaries(physicalCardId: physicalCardId)
            let (card, summaries) = try await (cardRequest, summariesRequest)

            virtualCard = card
            self.summaries = summaries
            hasLoaded = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func updateCardStatus(isActive: Bool) async {
        guard let currentCard = virtualCard,
              currentCard.isActive != isActive else {
            return
        }

        isUpdatingStatus = true

        defer {
            isUpdatingStatus = false
        }

        do {
            virtualCard = try await service.updateCardStatus(cardId: currentCard.id, isActive: isActive)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func generateNewCardNumber() async {
        guard let cardId = virtualCard?.id else { return }

        isGeneratingNewNumber = true

        defer {
            isGeneratingNewNumber = false
        }

        do {
            virtualCard = try await service.generateNewCardNumber(cardId: cardId)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func didCopyCardNumber() {}

    func showSecurityInformation() {}
}
