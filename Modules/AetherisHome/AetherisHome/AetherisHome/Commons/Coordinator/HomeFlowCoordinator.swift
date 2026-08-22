import Core
import AetherisAuthenticationInterface
import AetherisCards
import AetherisCardsInterface
import AetherisInsightsInterface
import AetherisNotificationsInterface
import AetherisTransfers
import SwiftUI

struct HomeFlowCoordinator: View {
    let coreService: any HasCoreService
    let identityValidation: any IdentityValidating
    let insightsFactory: InsightsFactoryInterface
    let notificationsFactory: NotificationsFactoryInterface
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
                            .navigationDestination(
                                for: HomeRoute.self,
                                destination: destinationView(for:)
                            )
                    ),
                    coreService: coreService,
                    path: $navigation.path
                ),
                coreService: coreService,
                identityValidation: identityValidation,
                selectedBeneficiary: $selectedBeneficiary,
                path: $navigation.path,
                onFinished: { navigation.reset() },
                onTransactionTap: showTransactionDetails
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
        tabBarVisibilityStore.isVisible = HomeFlowCoordinatorRouter.tabBarIsVisible(
            isAtRoot: navigation.isAtRoot
        )
    }

    func showTransactionDetails(_ transactionID: UUID) {
        CardsFactory.showTransactionDetails(transactionID: transactionID, path: $navigation.path)
    }
}

#Preview {
    HomeFlowCoordinator(
        coreService: DemoCoreService(delay: 0),
        identityValidation: HomePreviewIdentityValidator(),
        insightsFactory: HomePreviewInsightsFactory(),
        notificationsFactory: HomePreviewNotificationsFactory()
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

private struct HomePreviewNotificationsFactory: NotificationsFactoryInterface {
    func make(
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            Color.clear
                .onAppear(perform: onBack)
        )
    }
}

private struct HomePreviewInsightsFactory: InsightsFactoryInterface {
    func makeReport(
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            Color.clear
                .onAppear(perform: onBack)
        )
    }
}
