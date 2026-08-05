import Core
import AetherisAuthenticationInterface
import AetherisCards
import AetherisTransfers
import SwiftUI

struct HomeFlowCoordinator: View {
    let coreService: any HasCoreService
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore
    @State var selectedBeneficiary = BeneficiaryFixtures.defaultSelection
    @State var navigation = HomeNavigationState()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            TransfersFactory.makeNavigationHost(
                content: CardsFactory.makeNavigationHost(
                    content: AnyView(
                        rootView
                            .navigationDestination(for: HomeRoute.self, destination: destinationView(for:))
                    ),
                    coreService: coreService,
                    path: $navigation.path
                ),
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary,
                path: $navigation.path,
                onFinished: { navigation.reset() }
            )
        }
        .onAppear {
            syncTabBarVisibility()
        }
        .onChange(of: navigation.path.count) { _, _ in
            syncTabBarVisibility()
        }
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = navigation.isAtRoot
    }
}
