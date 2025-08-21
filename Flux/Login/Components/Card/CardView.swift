import SwiftUI

struct Card {
    var headline: String
    var title: String?
    var caption: String?
    var icon: String?
    var button: String
    var color: Color
}

struct CardView: View {
    @State var width: CGFloat = 350
    @State var card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(card.headline)
                        .foregroundStyle(.white)
                        .font(AppFont.roboto(.regular, size: 16))
                    
                    Spacer()
                    
                    HStack() {
                        if let title = card.title {
                            Text(title)
                                .foregroundStyle(.white)
                                .font(AppFont.roboto(.bold, size: 20))
                        }
                        
                        
                        Spacer()
                        
                        if let icon = card.icon {
                            Image(systemName: icon)
                                .font(.system(size: 40))
                                .foregroundStyle(.white)
                        }
                        
                    }

            
                    
                    if let caption = card.caption {
                        Text(caption)
                            .foregroundStyle(.white)
                            .font(AppFont.roboto(.regular, size: 16))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 325, height: 40)
                            .shadow(radius: 16)
                        
                        Text(card.button)
                            .foregroundStyle(.black)
                            .shadow(radius: 20)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .frame(width: width, height: 200)
    }
}

#Preview {
    let card = Card(headline: "Rewards Available",
                    title: "12,500 points",
                    caption: "Worth $125 in travel",
                    icon: "gift",
                    button: "Redeem",
                    color: .black)
    
    CardView(card: card)
}
