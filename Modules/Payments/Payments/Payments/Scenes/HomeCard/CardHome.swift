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
                .padding(.horizontal, AppSpacing.screenHorizontal)
                
                CardSwipe(cards: $cardsMock)
                
                HomeQuickActions(actions: CardOptions.mock)
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)
                
                FinancialSummaryContainer()
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)
            }
            .opacity(isLoading ? 0 : 1)
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: AppSpacing.bottomBarClearance)
            }

            CardHomeSkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .appScreenBackground()
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
