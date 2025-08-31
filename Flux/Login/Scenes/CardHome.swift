import SwiftUI

struct CardHome: View {
    let mocks: [FinancialSummaryModel] = [.init(image: "NetflixLogo",
                                                       title: "Netflix",
                                                       description: "Subscription",
                                                       value: "$ 20.00"),
                                                 .init(image: "applelogo",
                                                       title: "Apple.Com/Bill",
                                                       description: "Subscription",
                                                       value: "$ 9.00"),
                                                 .init(image: "ifoodlogo",
                                                       title: "Ifd* Bar do zé",
                                                       description: "Restaurant",
                                                       value: "$ 30.00"),
                                                 .init(image: "melissa",
                                                       title: "Transfer sent",
                                                       description: "Funds successfully transferred to Melissa",
                                                       value: "$ 250.00")]
    
    var body: some View {
        ScrollView(showsIndicators: false){
            NavBar(model: .init(firstText: "Cards",
                                hasInitialSpace: false))
            .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            CardSwipe(cards: CardsMock.creditCardMocks)
            
            Divider()
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    Spacer()
                    
                    GlassButton(model: .init(label: "Send",
                                             icon: "paperplane.fill")) {
                        print("tapped")
                    }
                    
                    GlassButton(model: .init(label: "Request",
                                             icon: "arrow.down.circle.fill")) {
                        print("tapped")
                    }
                    
                    GlassButton(model: .init(label: "Pay",
                                             icon: "creditcard.fill")) {
                        print("tapped")
                    }
                    
                    GlassButton(model: .init(label: "Top up",
                                             icon: "plus.circle.fill")) {
                        print("tapped")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 5)
            
            Divider()
                .padding(.horizontal)
            
            ForEach(mocks) { transfer in
                FinancialSummary(model: transfer)
                    .padding(.horizontal)
            }
        }
        .background(Color.backgroundColorA)
    }
}

#Preview {
    CardHome()
}
