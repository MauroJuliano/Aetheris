import SwiftUI

public struct CardSwipe: View {
    @State private var dragOffSet: CGSize = .zero
    @State private var topCardIndex: Int = 0
    @State private var selectedCard: Card? = nil
    @Binding var cards: [Card]
    
    var width: CGFloat = AppCardMetrics.swipeCardSize.width
    
    public init(cards: Binding<[Card]>) {
        self._cards = cards
    }
    
    public var body: some View {
        NavigationStack {
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
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    dragOffSet = value.translation
                                }
                                .onEnded { value in
                                    let threshold: CGFloat = 50
                                    
                                    if abs(value.translation.width) > threshold {
                                        let direction = value.translation.width < 0 ? -1 : 1
                                        let delay: Double = direction == -1 ? 0.18 : 0.20
                                        // Move away
                                        withAnimation(.smooth(duration: delay)) {
                                            dragOffSet.width = direction < 0 ? -width : width * 1.33 // To get passed the peaking cards
                                        } completion: {
                                            // Back to stack
                                            withAnimation(.smooth(duration: 0.5)) {
                                                topCardIndex = (topCardIndex + 1) % cards.count
                                                dragOffSet = .zero
                                            }
                                        }
                                    } else {
                                        withAnimation {
                                            dragOffSet = .zero
                                        }
                                    }
                                }
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    selectedCard = cards[index]
                                }
                        )
                }
                .padding()
            }
        }
        .navigationDestination(item: $selectedCard) { card in
//            switch card.content {
//            case .creditCard(let model):
//                // CardHome()
//            case .info(let model):
//                // InsuranceOnboarding()
//            }
            
        }
       
    }
}

#Preview {
    CardSwipe(cards: .constant(CardsMock.multipleTypeCards))
}
