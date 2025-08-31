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

#Preview {
    let card = Card(content: .info(.init(headline: "Rewards Available",
                                   title: "12,500 points",
                                   caption: "Worth $125 in travel",
                                   icon: "gift",
                                   button: "Redeem",
                                   color: .black)))
    
    CardView(card: card)
}
