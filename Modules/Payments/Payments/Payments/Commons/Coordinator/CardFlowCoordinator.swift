import Core
import PaymentsInterface
import SwiftUI

private enum CardFlowRoute: Hashable {
    case transactionHistory
}

struct CardFlowCoordinator: View {
    let coreService: any HasCoreService
    let onDismiss: (() -> Void)?
    @State private var path: [CardFlowRoute] = []
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore

    var body: some View {
        NavigationStack(path: $path) {
            HomeCardFactory.make(
                coreService: coreService,
                onBackAction: onDismiss,
                onTransactionHistoryTap: {
                    path.append(.transactionHistory)
                }
            )
            .navigationDestination(for: CardFlowRoute.self) { route in
                switch route {
                case .transactionHistory:
                    TransactionHistoryFactory.make(
                        coreService: coreService,
                        onBack: { popRoute() }
                    )
                }
            }
        }
        .onAppear {
            syncTabBarVisibility()
        }
        .onChange(of: path.count) { _, _ in
            syncTabBarVisibility()
        }
        .onDisappear {
            tabBarVisibilityStore.isVisible = true
        }
    }

    private func popRoute() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = path.isEmpty
    }
}
