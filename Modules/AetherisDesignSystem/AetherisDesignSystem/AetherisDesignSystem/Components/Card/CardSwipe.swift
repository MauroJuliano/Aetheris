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
}

private struct CardSwipeStackCard: View {
    let card: Card
    let index: Int
    let cardsCount: Int
    @Binding var topCardIndex: Int
    @Binding var dragOffset: CGSize
    @Binding var selectedCardIndex: Int
    let canSwipe: Bool
    let width: CGFloat
    let onTap: () -> Void

    private var visualIndex: Int {
        (index - topCardIndex + cardsCount) % cardsCount
    }

    private var progress: CGFloat {
        min(abs(dragOffset.width) / 150, 1)
    }

    private var signedProgress: CGFloat {
        (dragOffset.width >= 0 ? 1 : -1) * progress
    }

    private var fadeProgress: CGFloat {
        let threshold: CGFloat = 0.3
        return max(0, min((progress - threshold) / (1 - threshold), 1))
    }

    var body: some View {
        CardView(card: card)
            .frame(width: width, height: AppCardMetrics.swipeCardSize.height)
            .offset(cardOffset)
            .zIndex(Double(cardsCount - visualIndex))
            .rotationEffect(cardRotation, anchor: .bottom)
            .scaleEffect(cardScale)
            .opacity(cardOpacity)
            .offset(x: visualIndex == 0 ? 0 : CGFloat(visualIndex) * -3)
            .rotation3DEffect(.degrees(cardRotation3D), axis: (0, 1, 0))
            .contentShape(Rectangle())
            .modifier(
                CardSwipeInteractionModifier(
                    canSwipe: canSwipe,
                    width: width,
                    dragOffSet: $dragOffset,
                    topCardIndex: $topCardIndex,
                    selectedCardIndex: $selectedCardIndex,
                    cardsCount: cardsCount,
                    onTap: onTap
                )
            )
    }

    private var cardOffset: CGSize {
        CGSize(
            width: visualIndex == 0 ? dragOffset.width : CGFloat(visualIndex) * 10,
            height: visualIndex == 0 ? 0 : CGFloat(visualIndex) * -4
        )
    }

    private var cardRotation: Angle {
        .degrees(visualIndex == 0 ? 0 : Double(visualIndex) * 3 - Double(progress * 3))
    }

    private var cardScale: CGFloat {
        if visualIndex == 0 {
            return 1.0
        }

        if visualIndex == 1 {
            return 1.0 - CGFloat(visualIndex) * 0.06 + progress * 0.06
        }

        return 1.0 - CGFloat(visualIndex) * 0.06
    }

    private var cardOpacity: Double {
        switch visualIndex {
        case 0:
            return Double(1 - fadeProgress)
        case 1:
            return Double(0.72 + fadeProgress * 0.28)
        default:
            return 0.55
        }
    }

    private var cardRotation3D: Double {
        (visualIndex == 0 || visualIndex == 1) ? Double(10 * signedProgress) : 0
    }
}

private struct CardSwipeInteractionModifier: ViewModifier {
    let canSwipe: Bool
    let width: CGFloat
    @Binding var dragOffSet: CGSize
    @Binding var topCardIndex: Int
    @Binding var selectedCardIndex: Int
    let cardsCount: Int
    let onTap: () -> Void

    func body(content: Content) -> some View {
        if canSwipe {
            content
                .gesture(dragGesture)
                .simultaneousGesture(TapGesture().onEnded(onTap))
        } else {
            content
                .simultaneousGesture(TapGesture().onEnded(onTap))
        }
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                dragOffSet = value.translation
            }
            .onEnded { value in
                let threshold: CGFloat = 50

                if abs(value.translation.width) > threshold {
                    let direction = value.translation.width < 0 ? -1 : 1
                    let delay: Double = direction == -1 ? 0.18 : 0.20
                    withAnimation(.smooth(duration: delay)) {
                        dragOffSet.width = direction < 0 ? -width : width * 1.33
                    } completion: {
                        withAnimation(.smooth(duration: 0.5)) {
                            topCardIndex = (topCardIndex + 1) % cardsCount
                            selectedCardIndex = topCardIndex
                            dragOffSet = .zero
                        }
                    }
                } else {
                    withAnimation {
                        dragOffSet = .zero
                    }
                }
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
