import SwiftUI

@MainActor
public protocol HasCards {
    var cardsFactory: CardsFactoryInterface { get }
}

public protocol CardsFactoryInterface {
    @MainActor
    func make(onFinished: @escaping () -> Void) -> AnyView
}
