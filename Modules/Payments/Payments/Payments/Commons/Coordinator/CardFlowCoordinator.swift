import Core
import PaymentsInterface
import Foundation
import SwiftUI

private enum CardFlowRoute: Hashable {
    case transactionHistory(UUID)
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
                onTransactionHistoryTap: { cardId in
                    path.append(.transactionHistory(cardId))
                }
            )
            .navigationDestination(for: CardFlowRoute.self) { route in
                switch route {
                case .transactionHistory(let cardId):
                    TransactionHistoryFactory.make(
                        coreService: coreService,
                        cardId: cardId,
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
