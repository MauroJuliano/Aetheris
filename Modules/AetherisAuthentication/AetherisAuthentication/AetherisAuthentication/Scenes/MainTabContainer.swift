import AetherisDesignSystem
import PaymentsInterface
import SwiftUI

struct MainTabContainer: View {
    @State private var selectedIndex = 0
    @State private var showSendMoney = false
    @StateObject private var tabBarVisibilityStore = TabBarVisibilityStore()
    
    let paymentsFactory: PaymentsFactoryInterface
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            if tabBarVisibilityStore.isVisible {
                TabBarView(
                    selectedIndex: $selectedIndex,
                    onCenterTap: {
                        showSendMoney = true
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.22), value: tabBarVisibilityStore.isVisible)
        .onChange(of: selectedIndex) { _, _ in
            tabBarVisibilityStore.isVisible = true
        }
        .fullScreenCover(isPresented: $showSendMoney) {
            paymentsFactory.make(
                entryPoint: .sendMoney,
                onFinished: {
                    showSendMoney = false
                }
            )
            .environmentObject(tabBarVisibilityStore)
        }
        .background(Color.backgroundColorA.ignoresSafeArea())
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedIndex {
        case 0:
            paymentsFactory.make(entryPoint: .home, onFinished: {})
                .environmentObject(tabBarVisibilityStore)
        case 1:
            paymentsFactory.make(entryPoint: .card, onFinished: {})
                .environmentObject(tabBarVisibilityStore)
        case 2:
            paymentsFactory.make(entryPoint: .profile, onFinished: {})
                .environmentObject(tabBarVisibilityStore)
        default:
            EmptyView()
        }
    }
    
}
