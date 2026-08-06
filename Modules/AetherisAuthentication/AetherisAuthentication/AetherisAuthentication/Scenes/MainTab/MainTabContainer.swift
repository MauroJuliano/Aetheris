import AetherisDesignSystem
import AccountInterface
import AetherisAuthenticationInterface
import AetherisCardsInterface
import AetherisHomeInterface
import AetherisTransfersInterface
import SwiftUI

struct MainTabContainer: View {
    @State private var showSendMoney = false
    @StateObject private var tabBarVisibilityStore = TabBarVisibilityStore()
    @StateObject private var tabBarRoutingStore = TabBarRoutingStore()
    
    let homeFactory: HomeFactoryInterface
    let cardsFactory: CardsFactoryInterface
    let transfersFactory: TransfersFactoryInterface
    let accountFactory: AccountFactoryInterface
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            if tabBarVisibilityStore.isVisible {
                TabBarView(
                    selectedIndex: $tabBarRoutingStore.selectedIndex,
                    onCenterTap: {
                        showSendMoney = true
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.22), value: tabBarVisibilityStore.isVisible)
        .onChange(of: tabBarRoutingStore.selectedIndex) { _, _ in
            tabBarVisibilityStore.isVisible = true
        }
        .fullScreenCover(isPresented: $showSendMoney) {
            transfersFactory.make(onFinished: {
                    showSendMoney = false
                })
            .environmentObject(tabBarVisibilityStore)
            .environmentObject(tabBarRoutingStore)
        }
        .background(Color.backgroundColorA.ignoresSafeArea())
    }
    
    @ViewBuilder
    private var content: some View {
        ZStack {
            homeFactory.make()
                .environmentObject(tabBarVisibilityStore)
                .environmentObject(tabBarRoutingStore)
                .opacity(tabBarRoutingStore.selectedIndex == 0 ? 1 : 0)
                .allowsHitTesting(tabBarRoutingStore.selectedIndex == 0)
                .accessibilityHidden(tabBarRoutingStore.selectedIndex != 0)

            cardsFactory.make(onFinished: {})
                .environmentObject(tabBarVisibilityStore)
                .environmentObject(tabBarRoutingStore)
                .opacity(tabBarRoutingStore.selectedIndex == 1 ? 1 : 0)
                .allowsHitTesting(tabBarRoutingStore.selectedIndex == 1)
                .accessibilityHidden(tabBarRoutingStore.selectedIndex != 1)

            accountFactory.make(entryPoint: .profile, onFinished: {})
                .environmentObject(tabBarVisibilityStore)
                .environmentObject(tabBarRoutingStore)
                .opacity(tabBarRoutingStore.selectedIndex == 2 ? 1 : 0)
                .allowsHitTesting(tabBarRoutingStore.selectedIndex == 2)
                .accessibilityHidden(tabBarRoutingStore.selectedIndex != 2)
        }
    }
    
}
