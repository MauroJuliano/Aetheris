import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class CardHomePresentationModel: ObservableObject {
    @Published var selectedCardIndex = 0
    @Published private(set) var isCardDetailsTransitioning = false
    @Published private(set) var isSummariesTransitioning = false

    private var didApplyInitialSelection = false
    private var cardDetailsTransitionTask: Task<Void, Never>?
    private var summariesTransitionTask: Task<Void, Never>?

    func applyInitialSelection(cardID: UUID?, cards: [Card]) {
        guard !didApplyInitialSelection,
              let cardID,
              let index = cards.firstIndex(where: { $0.id == cardID }) else {
            return
        }

        selectedCardIndex = index
        didApplyInitialSelection = true
    }

    @discardableResult
    func applyRequestedSelection(cardID: UUID?, cards: [Card]) -> Bool {
        guard let cardID,
              let index = cards.firstIndex(where: { $0.id == cardID }) else {
            return false
        }

        selectedCardIndex = index
        return true
    }

    func refreshContentTransition(isLoading: Bool, isEmpty: Bool) {
        guard !isLoading, !isEmpty else { return }
        refreshCardDetailsTransition()
        refreshSummariesTransition()
    }

    private func refreshCardDetailsTransition() {
        cardDetailsTransitionTask?.cancel()
        cardDetailsTransitionTask = transitionTask(
            setTransitioning: { self.isCardDetailsTransitioning = $0 }
        )
    }

    private func refreshSummariesTransition() {
        summariesTransitionTask?.cancel()
        summariesTransitionTask = transitionTask(
            setTransitioning: { self.isSummariesTransitioning = $0 }
        )
    }

    private func transitionTask(
        setTransitioning: @escaping @MainActor (Bool) -> Void
    ) -> Task<Void, Never> {
        Task { @MainActor in
            withAnimation(.easeInOut(duration: 0.12)) {
                setTransitioning(true)
            }

            try? await Task.sleep(nanoseconds: 320_000_000)
            guard !Task.isCancelled else { return }

            withAnimation(.easeInOut(duration: 0.22)) {
                setTransitioning(false)
            }
        }
    }
}
