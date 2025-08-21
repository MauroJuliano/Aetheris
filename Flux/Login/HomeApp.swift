import SwiftUI

struct HomeApp: View {
    var body: some View {
        ScrollView {
            ZStack() {
                Color(.background)
                    .ignoresSafeArea()
                
                VStack {
                    NavBar()
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    BalanceView()
                    
                    CardSwipe()
                        .shadow(radius: 20)
                    
                    Recipients()
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            Color.clear
                                .frame(width: 25)
                            
                            CardDistribution(primaryColor: .white, backgroundColor: .black, spectrumRatio: .vertical)
                                
                            VStack {
                                CardDistribution(primaryColor: .white, backgroundColor: .accentColorB, spectrumRatio: .horizontal)
                                CardDistribution(primaryColor: .white, backgroundColor: .black, spectrumRatio: .horizontal)
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    HomeApp()
}
