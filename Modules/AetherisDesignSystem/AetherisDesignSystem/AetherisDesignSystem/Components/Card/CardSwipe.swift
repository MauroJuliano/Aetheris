import SwiftUI

public struct CardSwipe: View {
    @State private var dragOffSet: CGSize = .zero
    @State private var topCardIndex: Int = 0
    @Binding var cards: [Card]
    let onTap: () -> Void
    
    var width: CGFloat = AppCardMetrics.swipeCardSize.width
    
    private var canSwipe: Bool {
        cards.count > 1
    }
    
    public init(cards: Binding<[Card]>, onTap: @escaping () -> Void = {}) {
        self._cards = cards
        self.onTap = onTap
    }
    
    public var body: some View {
        Group {
            if cards.count <= 1 {
                if let card = cards.first {
                    CardView(card: card)
                        .frame(width: width, height: AppCardMetrics.swipeCardSize.height)
                        .zIndex(1)
                        .contentShape(Rectangle())
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    onTap()
                                }
                        )
                }
            } else {
                ZStack {
                    ForEach(cards.indices, id: \.self) { index in
                        let visualIndex = (index - topCardIndex + cards.count) % cards.count
                        let progress = min(abs(dragOffSet.width) / 150, 1)
                        let signedProgress = (dragOffSet.width >= 0 ? 1 : -1) * progress
                        
                        CardView(card: cards[index])
                            .frame(width: width, height: AppCardMetrics.swipeCardSize.height)
                            .offset(x: visualIndex == 0 ? dragOffSet.width : Double(visualIndex) * 10,
                                    y: visualIndex == 0 ? 0 : Double(visualIndex) * -4)
                        
                            .zIndex(Double(cards.count - visualIndex))
                        
                            .rotationEffect(
                                .degrees( visualIndex == 0 ? 0 : Double(visualIndex) * 3 - progress * 3), anchor: .bottom )
                            .scaleEffect(visualIndex == 0 ? 1.0 : visualIndex == 1 ? (1.0 - Double(visualIndex) * 0.06 + progress * 0.06) : (1.0 - Double(visualIndex) * 0.06))
                            .offset(x: visualIndex == 0 ? 0 : Double(visualIndex) * -3)
                        
                            .rotation3DEffect(
                                .degrees(
                                    (visualIndex == 0 || visualIndex == 1) ? 10 * signedProgress : 0),
                                axis: (0, 1, 0))
                            .contentShape(Rectangle())
                            .modifier(CardSwipeInteractionModifier(
                                canSwipe: canSwipe,
                                width: width,
                                dragOffSet: $dragOffSet,
                                topCardIndex: $topCardIndex,
                                cardsCount: cards.count,
                                onTap: onTap
                            ))
                    }
                    .padding()
                }
            }
        }
    }
}

private struct CardSwipeInteractionModifier: ViewModifier {
    let canSwipe: Bool
    let width: CGFloat
    @Binding var dragOffSet: CGSize
    @Binding var topCardIndex: Int
    let cardsCount: Int
    let onTap: () -> Void
    
    func body(content: Content) -> some View {
        if canSwipe {
            content
                .gesture(dragGesture)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            onTap()
                        }
                )
        } else {
            content
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            onTap()
                        }
                )
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
