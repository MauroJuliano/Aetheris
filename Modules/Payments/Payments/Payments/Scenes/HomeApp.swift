import AetherisDesignSystem
import SwiftUI

struct HomeApp: View {
    @State private var shouldPresentCardHome: Bool = false
    @State private var shouldPresentSIN: Bool = false
    @State private var shouldPresentLoan: Bool = false
    @State private var showNotifications: Bool = false
    @State private var isLoading = true
    @State private var cardsMock = CardsMock.multipleTypeCards
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ZStack() {
                    VStack {
                        NavBar(model: .init(firstText: "Welcome, ",
                                            secondText: "Blake!",
                                            hasInitialSpace: false),
                               onRightButtonAction: {
                            showNotifications = true
                        })
                        
                        Divider()
                        
                        BalanceView()
                        
                        CardSwipe(cards: $cardsMock)
                        
                        Divider()
                        
                        Recipients()
                        
                        Divider()
                        
                        HStack(spacing: 35) {
                            CardDistribution(primaryColor: .white,
                                             backgroundColor: .black,
                                             spectrumRatio: .vertical,
                                             model: .mockCreditCard)
                            .gesture(
                                TapGesture()
                                    .onEnded {
                                        shouldPresentCardHome = true
                                    }
                            )
                            
                            VStack {
                                CardDistribution(primaryColor: .white,
                                                 backgroundColor: .accentColorB,
                                                 spectrumRatio: .horizontal,
                                                 model: .mockLoans)
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            shouldPresentLoan = true
                                        }
                                )
                                
                                CardDistribution(primaryColor: .white,
                                                 backgroundColor: .black,
                                                 spectrumRatio: .horizontal,
                                                 model: .mockInvestiment)
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            shouldPresentSIN = true
                                        }
                                )
                            }
                        }
                    }
                }
            }
            .opacity(isLoading ? 0 : 1)
            .padding(.horizontal)
            .navigationDestination(isPresented: $shouldPresentCardHome) {
                CardHome()
            }
            .navigationDestination(isPresented: $shouldPresentLoan) {
                CardInsurance()
            }
            
            .navigationDestination(isPresented: $showNotifications) {
                NotificationsCentre(isPresented: $showNotifications)
            }
            .navigationDestination(isPresented: $shouldPresentSIN) {
                InsuranceOnboarding()
            }
            
            HomeAppSkeleton()
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
    HomeApp()
}
