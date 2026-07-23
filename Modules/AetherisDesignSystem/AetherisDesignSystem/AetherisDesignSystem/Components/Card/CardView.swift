import SwiftUI


struct CardView: View {
    @State var width: CGFloat = 350
    @State var card: Card
    
    var body: some View {
        switch card.content {
        case let .info(model):
            CardInfoView(infoModel: model)
        case let .creditCard(model):
            CreditCardView(model: model)
        }
    }
}

