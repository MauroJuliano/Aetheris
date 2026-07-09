import AetherisDesignSystem
import SwiftUI

struct HomeApp: View {
    @State private var shouldPresentCardHome: Bool = false
    @State private var shouldPresentSIN: Bool = false
    @State private var shouldPresentLoan: Bool = false
    @State private var showNotifications: Bool = false
    @State private var showViewReport: Bool = false
    @State private var showReportError: Bool = false
    @State private var isLoading = true
    @State private var cardsMock = CardsMock.multipleTypeCards
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                NavBar(model: .init(firstText: "Welcome, ",
                                    secondText: "Blake!",
                                    hasInitialSpace: false),
                       onRightButtonAction: {
                    showNotifications = true
                })
                
                BalanceView()
                
                CardSwipe(cards: $cardsMock)
                
                RecipientsContainer()
                
                QuickActions()
                
                SpendingThisMonthView(
                    onViewReportTap: {
                        showViewReport = true
                    }
                )
                
            }
            .opacity(isLoading ? 0 : 1)
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: AppSpacing.bottomBarClearance)
            }
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
            .navigationDestination(isPresented: $showViewReport) {
                ViewReportView {
                    showViewReport = false
                    showReportError = true
                }
            }
            .navigationDestination(isPresented: $showReportError) {
                FullScreenErrorView(
                    title: "Something went wrong",
                    description: "We couldn't load your information. Please check your connection and try again.",
                    primaryButtonTitle: "Try again",
                    secondaryButtonTitle: "Try later",
                    onPrimaryAction: {
                        showReportError = false
                        showViewReport = true
                    },
                    onSecondaryAction: {
                        showReportError = false
                    }
                )
            }
            
            HomeAppSkeleton()
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
    HomeApp()
}
