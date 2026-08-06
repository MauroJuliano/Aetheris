import Combine
import Foundation
import SwiftUI

@MainActor
public protocol HasCards {
    var cardsFactory: CardsFactoryInterface { get }
}

public protocol CardsFactoryInterface {
    @MainActor
    func make(onFinished: @escaping () -> Void) -> AnyView
}

@MainActor
public final class TabBarRoutingStore: ObservableObject {
    @Published public var selectedIndex = 0
    @Published public var pendingCardsSelectedCardId: UUID?

    public init() {}

    public func showCards(selectedCardId: UUID? = nil) {
        pendingCardsSelectedCardId = selectedCardId
        selectedIndex = 1
    }

    public func clearPendingCardsSelection() {
        pendingCardsSelectedCardId = nil
    }
}
