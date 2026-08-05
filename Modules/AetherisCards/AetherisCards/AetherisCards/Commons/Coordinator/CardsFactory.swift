import AetherisCardsInterface
import Core
import SwiftUI

public final class CardsFactory: CardsFactoryInterface {
    private let coreService: any HasCoreService

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    @MainActor
    public func make(onFinished: @escaping () -> Void) -> AnyView {
        AnyView(CardFlowCoordinator(coreService: coreService, onDismiss: nil))
    }

    @MainActor
    public static func makeEmbedded(
        coreService: any HasCoreService,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(HomeCardFactory.make(
            coreService: coreService,
            onBackAction: onFinished,
            onTransactionHistoryTap: { cardID in
                path.wrappedValue.append(CardFlowRoute.transactionHistory(cardID))
            }
        ))
    }

    @MainActor
    public static func makeNavigationHost(
        content: AnyView,
        coreService: any HasCoreService,
        path: Binding<NavigationPath>
    ) -> AnyView {
        AnyView(
            content.navigationDestination(for: CardFlowRoute.self) { route in
                switch route {
                case .transactionHistory(let cardID):
                    TransactionHistoryFactory.make(
                        coreService: coreService,
                        cardId: cardID,
                        onBack: {
                            guard !path.wrappedValue.isEmpty else { return }
                            path.wrappedValue.removeLast()
                        }
                    )
                }
            }
        )
    }
}
