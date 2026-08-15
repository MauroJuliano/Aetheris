import Core
import AetherisAuthenticationInterface
import AetherisCards
import AetherisCardsInterface
import AetherisTransfers
import SwiftUI

struct HomeFlowCoordinator: View {
    let coreService: any HasCoreService
    let identityValidation: any IdentityValidating
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore
    @EnvironmentObject var tabBarRoutingStore: TabBarRoutingStore
    @State var selectedBeneficiary: Beneficiary?
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
                identityValidation: identityValidation,
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

#Preview {
    HomeFlowCoordinator(
        coreService: DemoCoreService(delay: 0),
        identityValidation: HomePreviewIdentityValidator()
    )
    .environmentObject(TabBarVisibilityStore())
    .environmentObject(TabBarRoutingStore())
}

private struct HomePreviewIdentityValidator: IdentityValidating {
    @MainActor
    func authenticate(
        content: IdentityValidationContent,
        onCancel: @escaping () -> Void,
        onResult: @escaping (IdentityValidationResult) -> Void
    ) -> AnyView {
        AnyView(
            Color.clear
                .onAppear {
                    onResult(
                        .authorized(
                            IdentityAuthorization(
                                token: "preview-token",
                                expiresAt: "2026-08-07T00:00:00Z"
                            )
                        )
                    )
                }
        )
    }
}
