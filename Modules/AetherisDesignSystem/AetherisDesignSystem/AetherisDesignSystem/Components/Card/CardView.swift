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
}
