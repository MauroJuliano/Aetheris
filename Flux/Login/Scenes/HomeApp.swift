import SwiftUI

struct HomeApp: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack() {
                VStack {
                    NavBar(model: .init(firstText: "Welcome, ",
                                        secondText: "Blake!",
                                        hasInitialSpace: false))
                    
                    Divider()
                    
                    BalanceView()
                    
                    CardSwipe(cards: CardsMock.multipleTypeCards)
                    
                    Divider()
                    
                    Recipients()
                    
                    Divider()
                    
                    HStack(spacing: 35) {
                        CardDistribution(primaryColor: .white,
                                         backgroundColor: .black,
                                         spectrumRatio: .vertical,
                                         model: .mockCreditCard)
                        
                        VStack {
                            CardDistribution(primaryColor: .white,
                                             backgroundColor: .accentColorB,
                                             spectrumRatio: .horizontal,
                                             model: .mockLoans)
                            CardDistribution(primaryColor: .white,
                                             backgroundColor: .black,
                                             spectrumRatio: .horizontal,
                                             model: .mockInvestiment)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)
    }
}

#Preview {
    HomeApp()
}
