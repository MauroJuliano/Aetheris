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

    var displayedCard: VirtualCardModel? {
        virtualCard ?? (isLoading ? .loadingPlaceholder : nil)
    }

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
            let dashboard = try await service.loadDashboard(physicalCardId: physicalCardId)

            virtualCard = dashboard.virtualCard
            summaries = dashboard.summaries
            hasLoaded = true
        } catch {
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.VirtualCard.unavailableTitle
            )
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
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.VirtualCard.unavailableTitle
            )
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
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.VirtualCard.unavailableTitle
            )
        }
    }

    func didCopyCardNumber() {}

    func showSecurityInformation() {}
}

private extension VirtualCardModel {
    static let loadingPlaceholder = VirtualCardModel(
        id: UUID(),
        physicalCardId: UUID(),
        holderName: "Loading",
        cardNumber: "0000000000000000",
        expirationDate: "00/00",
        securityCode: "000",
        brand: .visa,
        style: .aurora,
        availableLimit: 0,
        totalLimit: 0,
        monthlyExpenses: 0,
        isActive: false
    )
}
