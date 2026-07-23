import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class HomeCardViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published var cards: [Card] = []
    @Published private(set) var summaries: [FinancialSummaryModel] = []
    @Published private(set) var quickActions: [CardOptions] = []

    private let service: any HomeCardServicing

    init(service: any HomeCardServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            async let dashboard = service.loadDashboard()
            async let quickActions = service.loadQuickActions()

            let loadedDashboard = try await dashboard
            let loadedQuickActions = try await quickActions

            cards = loadedDashboard.cards
            summaries = loadedDashboard.summaries
            self.quickActions = loadedQuickActions
            isEmpty = cards.isEmpty && summaries.isEmpty
        } catch {
            errorMessage = "We could not load your cards and activity right now."
        }

        isLoading = false
    }
}
