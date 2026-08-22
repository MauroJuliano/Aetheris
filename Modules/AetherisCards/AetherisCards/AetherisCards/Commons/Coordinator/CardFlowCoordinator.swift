import Core
import AetherisAuthenticationInterface
import AetherisCardsInterface
import Foundation
import SwiftUI

enum CardFlowRoute: Hashable {
    case transactionHistory(UUID)
    case transactionDetails(UUID)
    case virtualCard(UUID)
    case currentInvoice(UUID)
    case cardLock(UUID)
}

struct CardNavigationState {
    var path: [CardFlowRoute] = []
    var isAtRoot: Bool { path.isEmpty }

    mutating func showTransactionHistory(cardID: UUID) {
        path.append(.transactionHistory(cardID))
    }

    mutating func showTransactionDetails(transactionID: UUID) {
        path.append(.transactionDetails(transactionID))
    }

    mutating func showVirtualCard(physicalCardID: UUID) {
        path.append(.virtualCard(physicalCardID))
    }

    mutating func showCurrentInvoice(cardID: UUID) {
        path.append(.currentInvoice(cardID))
    }

    mutating func showCardLock(cardID: UUID) {
        path.append(.cardLock(cardID))
    }

    mutating func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}

struct CardFlowCoordinator: View {
    let coreService: any HasCoreService
    let onDismiss: (() -> Void)?
    let onSendMoneyTap: () -> Void
    let onRequestMoneyTap: () -> Void
    @State private var navigation = CardNavigationState()
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore
    @EnvironmentObject private var tabBarRoutingStore: TabBarRoutingStore

    var body: some View {
        NavigationStack(path: $navigation.path) {
            HomeCardFactory.make(
                coreService: coreService,
                selectedCardRequestId: tabBarRoutingStore.pendingCardsSelectedCardId,
                onSelectedCardRequestApplied: {
                    tabBarRoutingStore.clearPendingCardsSelection()
                },
                onBackAction: onDismiss,
                onTransactionHistoryTap: { cardId in
                    navigation.showTransactionHistory(cardID: cardId)
                },
                onVirtualCardTap: { cardId in
                    navigation.showVirtualCard(physicalCardID: cardId)
                },
                onInvoiceTap: { cardId in
                    navigation.showCurrentInvoice(cardID: cardId)
                },
                onCardLockTap: { cardId in
                    navigation.showCardLock(cardID: cardId)
                },
                onSendMoneyTap: {
                    onSendMoneyTap()
                },
                onRequestMoneyTap: {
                    onRequestMoneyTap()
                }
            )
            .navigationDestination(for: CardFlowRoute.self) { route in
                switch route {
                case .transactionHistory(let cardId):
                    TransactionHistoryFactory.make(
                        coreService: coreService,
                        cardId: cardId,
                        onBack: { popRoute() },
                        onTransactionTap: { transactionId in
                            navigation.showTransactionDetails(transactionID: transactionId)
                        }
                    )
                case .transactionDetails(let transactionId):
                    TransactionDetailsFactory.make(
                        coreService: coreService,
                        transactionId: transactionId,
                        onBackAction: { popRoute() }
                    )
                case .virtualCard(let physicalCardId):
                    VirtualCardFactory.make(
                        coreService: coreService,
                        physicalCardId: physicalCardId,
                        onBackAction: { popRoute() },
                        onTransactionHistoryTap: { cardId in
                            navigation.showTransactionHistory(cardID: cardId)
                        }
                    )
                case .currentInvoice(let cardId):
                    CurrentInvoiceFactory.make(
                        coreService: coreService,
                        cardId: cardId,
                        onBackAction: { popRoute() },
                        onTransactionHistoryTap: { invoiceId in
                            navigation.showTransactionHistory(cardID: invoiceId)
                        }
                    )
                case .cardLock(let cardId):
                    CardLockFactory.make(
                        coreService: coreService,
                        cardId: cardId,
                        onBackAction: { popRoute() },
                        onVirtualCardTap: { cardId in
                            navigation.showVirtualCard(physicalCardID: cardId)
                        }
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

#Preview {
    CardFlowCoordinator(
        coreService: DemoCoreService(delay: 0),
        onDismiss: nil,
        onSendMoneyTap: {},
        onRequestMoneyTap: {}
    )
    .environmentObject(TabBarVisibilityStore())
    .environmentObject(TabBarRoutingStore())
}
