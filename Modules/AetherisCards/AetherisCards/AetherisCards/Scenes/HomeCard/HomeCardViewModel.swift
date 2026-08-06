import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class HomeCardViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published var cards: [Card] = []
    @Published private(set) var cardDetails: [CardDetailsModel] = []
    @Published private(set) var summaries: [FinancialSummaryModel] = []
    @Published private(set) var quickActions: [CardOptions] = []

    private let service: any HomeCardServicing
    private var hasLoaded = false

    init(service: any HomeCardServicing) {
        self.service = service
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await load()
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            let loadedDashboard = try await service.loadDashboard()
            cards = loadedDashboard.cards
            cardDetails = loadedDashboard.cardDetails
            summaries = loadedDashboard.summaries
            quickActions = loadedDashboard.quickActions
            isEmpty = cards.isEmpty && summaries.isEmpty
        } catch {
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: "We could not load your cards and activity right now."
            )
        }

        isLoading = false
    }
}
