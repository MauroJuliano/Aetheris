import SwiftUI

struct CardSwipeInteractionModifier: ViewModifier {
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
