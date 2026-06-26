import AetherisDesignSystem
import SwiftUI

struct CardHome: View {    
    @State private var cardsMock = CardsMock.creditCardMocks
    
    var body: some View {
        ScrollView(showsIndicators: false){
            NavBar(model: .init(firstText: "Cards",
                                hasInitialSpace: false))
            .padding(.horizontal)
            
            CardSwipe(cards: $cardsMock)
            
            HomeQuickActions(actions: CardOptions.mock)
                .padding(.horizontal)
                .padding(.vertical, 5)
            
            FinancialSummaryContainer()
                .padding(.horizontal)
                .padding(.vertical, 5)
        }
        .background(Color.backgroundColorA)
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: 100)
        }
    }
}

#Preview {
    CardHome()
}
