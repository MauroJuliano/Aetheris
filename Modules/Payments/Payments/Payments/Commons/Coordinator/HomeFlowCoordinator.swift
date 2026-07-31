import Core
import PaymentsInterface
import SwiftUI

struct HomeFlowCoordinator: View {
    let coreService: any HasCoreService
    @Binding var selectedBeneficiary: Beneficiary
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore
    @State var navigation = HomeNavigationState()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            rootView
                .navigationDestination(for: HomeRoute.self, destination: destinationView(for:))
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
