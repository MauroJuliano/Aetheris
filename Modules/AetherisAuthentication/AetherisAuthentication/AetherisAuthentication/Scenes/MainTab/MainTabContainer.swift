import AetherisDesignSystem
import AccountInterface
import AetherisAuthenticationInterface
import AetherisCardsInterface
import AetherisHomeInterface
import AetherisTransfersInterface
import SwiftUI

struct MainTabContainer: View {
    @State private var showSendMoney = false
    @State private var cardsNavigationPath = NavigationPath()
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
            syncTabBarVisibility()
        }
        .onChange(of: cardsNavigationPath.count) { _, _ in
            syncTabBarVisibility()
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

            cardsNavigation
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

    private var cardsNavigation: some View {
        NavigationStack(path: $cardsNavigationPath) {
            transfersFactory.makeNavigationHost(
                content: cardsFactory.makeNavigationHost(
                    content: cardsFactory.makeEmbedded(
                        path: $cardsNavigationPath,
                        onFinished: resetCardsNavigation,
                        onSendMoneyTap: { cardsNavigationPath.append(MainTabRoute.sendMoney) },
                        onRequestMoneyTap: { cardsNavigationPath.append(MainTabRoute.requestMoney) }
                    ),
                    path: $cardsNavigationPath
                ),
                path: $cardsNavigationPath,
                onFinished: resetCardsNavigation
            )
            .navigationDestination(for: MainTabRoute.self) { route in
                switch route {
                case .sendMoney:
                    transfersFactory.makeEmbedded(
                        path: $cardsNavigationPath,
                        onFinished: popCardsNavigation
                    )
                case .requestMoney:
                    transfersFactory.makeRequestMoneyEmbedded(
                        path: $cardsNavigationPath,
                        onFinished: popCardsNavigation
                    )
                }
            }
        }
    }

    private func popCardsNavigation() {
        guard !cardsNavigationPath.isEmpty else { return }
        cardsNavigationPath.removeLast()
    }

    private func resetCardsNavigation() {
        cardsNavigationPath = NavigationPath()
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = tabBarRoutingStore.selectedIndex != 1 || cardsNavigationPath.isEmpty
    }

    
}


#Preview {
    MainTabContainer(
        homeFactory: AuthenticationPreviewHomeFactory(),
        cardsFactory: AuthenticationPreviewCardsFactory(),
        transfersFactory: AuthenticationPreviewTransfersFactory(),
        accountFactory: AuthenticationPreviewAccountFactory()
    )
}
