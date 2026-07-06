import AetherisDesignSystem
import SwiftUI

struct CardHome: View {    
    @State private var cardsMock = CardsMock.creditCardMocks
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
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
            .opacity(isLoading ? 0 : 1)
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: 100)
            }

            CardHomeSkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .background(Color.backgroundColorA)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    CardHome()
}
