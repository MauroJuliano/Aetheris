import SwiftUI

struct CardSwipe: View {
    var cards = [
        Card(
            headline: "Capital One Quicksilver",
            title: "$5,000",
            caption: "**** 8821",
            icon: "creditcard.fill",
            button: "View Card",
            color: .black
        ),
        Card(headline: "Rewards Available",
             title: "12,500 points",
             caption: "Worth $125 in travel",
             icon: "gift",
             button: "Redeem",
             color: .primaryColor),
        Card(headline: "Monthly Spending",
             title: "You spent $2,310 in August",
             caption: "Top category: Restaurants 🍔",
             icon: "chart.pie.fill",
             button: "See Insights",
             color: .secondaryColor),
        Card(
            headline: "Special Offer",
            title: "Travel Insurance",
            caption: "Protect your trips starting at $12/mo",
            icon: "shield.fill",
            button: "Learn More",
            color: .accentColorB
        ),
        Card(
            headline: "No Credit Card Yet?",
            title: "Build Your Credit",
            caption: "Apply now for a Platinum Secured Card",
            icon: "star.fill",
            button: "Apply Now",
            color: .secondaryColor
            
        )]
    
    @State private var dragOffSet: CGSize = .zero
    @State private var topCardIndex: Int = 0
    
    var width: CGFloat = 350
    
    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                let visualIndex = (index - topCardIndex + cards.count) % cards.count
                let progress = min(abs(dragOffSet.width) / 150, 1)
                let signedProgress = (dragOffSet.width >= 0 ? 1 : -1) * progress
                
                CardView(card: cards[index])
                    .frame(width: width, height: 200)
                    .foregroundStyle(cards[index].color)
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
            }
            .padding()
        }
    }
}

#Preview {
    CardSwipe()
}

