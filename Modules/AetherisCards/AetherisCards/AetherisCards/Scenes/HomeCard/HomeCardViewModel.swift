import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class HomeCardViewModel: ObservableObject {
    enum QuickActionDestination: Equatable {
        case sendMoney
        case requestMoney
        case virtualCard(UUID)
        case cardLock(UUID)
        case custom(CardOptions)
    }

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
                fallback: Strings.HomeCard.loadFailed
            )
        }

        isLoading = false
    }

    func cardId(at index: Int) -> UUID? {
        guard !cards.isEmpty else { return nil }
        return cards[min(max(index, 0), cards.count - 1)].id
    }

    func cardDetails(at index: Int) -> CardDetailsModel? {
        guard let cardId = cardId(at: index) else { return nil }
        return cardDetails.first { $0.cardId == cardId }
    }

    func summaries(at index: Int) -> [FinancialSummaryModel] {
        guard let cardId = cardId(at: index) else { return summaries }
        let matchingSummaries = summaries.filter { $0.cardId == cardId }
        return matchingSummaries.isEmpty ? summaries : matchingSummaries
    }

    func quickActions(at index: Int) -> [CardOptions] {
        let baseActions = quickActions
            .filter { !CardOptions.replacedQuickActionIds.contains($0.id) }
            .prefix(2)

        return Array(baseActions) + [
            .virtualCard(),
            .cardLock(isBlocked: cardDetails(at: index)?.isBlocked == true)
        ]
    }

    func quickActionItems(at index: Int) -> [CompactQuickActionItem] {
        quickActions(at: index).map { .init(id: $0.id, title: $0.label, icon: $0.icon) }
    }

    func quickActionDestination(
        for option: CardOptions,
        at index: Int
    ) -> QuickActionDestination? {
        guard let cardId = cardId(at: index) else { return nil }

        switch option.id {
        case CardOptions.sendId:
            return .sendMoney
        case CardOptions.requestId:
            return .requestMoney
        case CardOptions.virtualCardId:
            return .virtualCard(cardId)
        case CardOptions.cardLockId:
            return .cardLock(cardId)
        default:
            return .custom(option)
        }
    }
}
