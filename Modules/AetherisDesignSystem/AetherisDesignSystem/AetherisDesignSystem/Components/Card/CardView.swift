import SwiftUI


struct CardView: View {
    @State var width: CGFloat = 350
    @State var card: Card
    
    @ViewBuilder
    var body: some View {
        switch card.content {
        case let .creditCard(model):
            CreditCardView(model: model, theme: model.style.theme)
        }
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            CardViewSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    CardView(card: CardsMock.creditCardMocks[0])
        .padding()
        .appScreenBackground()
}
