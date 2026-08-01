import Core
import PaymentsInterface
import Foundation
import SwiftUI

enum CardFlowRoute: Hashable {
    case transactionHistory(UUID)
}

struct CardNavigationState {
    var path: [CardFlowRoute] = []
    var isAtRoot: Bool { path.isEmpty }

    mutating func showTransactionHistory(cardID: UUID) {
        path.append(.transactionHistory(cardID))
    }

    mutating func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}

struct CardFlowCoordinator: View {
    let coreService: any HasCoreService
    let onDismiss: (() -> Void)?
    @State private var navigation = CardNavigationState()
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore

    var body: some View {
        NavigationStack(path: $navigation.path) {
            HomeCardFactory.make(
                coreService: coreService,
                onBackAction: onDismiss,
                onTransactionHistoryTap: { cardId in
                    navigation.showTransactionHistory(cardID: cardId)
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
        .onChange(of: navigation.path.count) { _, _ in
            syncTabBarVisibility()
        }
        .onDisappear {
            tabBarVisibilityStore.isVisible = true
        }
    }

    private func popRoute() {
        navigation.pop()
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = navigation.isAtRoot
    }
}
