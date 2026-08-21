import Foundation
import SwiftUI

public struct CardSwipe: View {
    @State private var dragOffSet: CGSize = .zero
    @State private var topCardIndex: Int = 0
    @Binding var cards: [Card]
    @Binding var selectedCardIndex: Int
    let onTap: () -> Void

    private let width = AppCardMetrics.swipeCardSize.width

    private var canSwipe: Bool {
        cards.count > 1
    }

    public init(
        cards: Binding<[Card]>,
        selectedCardIndex: Binding<Int>,
        onTap: @escaping () -> Void = {}
    ) {
        self._cards = cards
        self._selectedCardIndex = selectedCardIndex
        self.onTap = onTap
    }

    public var body: some View {
        Group {
            if cards.count <= 1 {
                singleCardView
            } else {
                stackedCardsView
            }
        }
        .onAppear {
            syncTopCardIndex(with: selectedCardIndex)
        }
        .onChange(of: cards.count) { _, _ in
            syncTopCardIndex(with: selectedCardIndex)
        }
        .onChange(of: topCardIndex) { _, _ in
            syncSelectedCardIndex()
        }
        .onChange(of: selectedCardIndex) { _, newValue in
            syncTopCardIndex(with: newValue)
        }
    }

    @ViewBuilder
    private var singleCardView: some View {
        if let card = cards.first {
            CardView(card: card)
                .frame(width: width, height: AppCardMetrics.swipeCardSize.height)
                .zIndex(1)
                .contentShape(Rectangle())
                .simultaneousGesture(TapGesture().onEnded(onTap))
        }
    }

    private var stackedCardsView: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardSwipeStackCard(
                    card: cards[index],
                    index: index,
                    cardsCount: cards.count,
                    topCardIndex: $topCardIndex,
                    dragOffset: $dragOffSet,
                    selectedCardIndex: $selectedCardIndex,
                    canSwipe: canSwipe,
                    width: width,
                    onTap: onTap
                )
            }
        }
        .padding()
    }

    private func syncSelectedCardIndex() {
        guard !cards.isEmpty else {
            selectedCardIndex = 0
            return
        }

        selectedCardIndex = min(max(topCardIndex, 0), cards.count - 1)
    }

    private func syncTopCardIndex(with selectedIndex: Int) {
        guard !cards.isEmpty else {
            topCardIndex = 0
            return
        }

        let safeIndex = min(max(selectedIndex, 0), cards.count - 1)
        guard topCardIndex != safeIndex else { return }

        dragOffSet = .zero
        topCardIndex = safeIndex
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            CardSwipeSkeleton()
        } else {
            self
        }
    }
}


#Preview {
    @Previewable @State var cards = CardsMock.creditCardMocks
    @Previewable @State var selectedIndex = 0

    CardSwipe(
        cards: $cards,
        selectedCardIndex: $selectedIndex
    )
    .padding()
    .appScreenBackground()
}
