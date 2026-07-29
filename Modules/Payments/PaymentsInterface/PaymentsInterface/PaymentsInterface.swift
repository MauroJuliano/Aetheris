import Combine
import SwiftUI

public final class TabBarVisibilityStore: ObservableObject {
    @Published public var isVisible = true

    public init() {}
}

public enum PaymentsEntryPoint {
    case home
    case card
    case sendMoney
    case profile
}

public protocol HasPayments {
    var paymentsFactory: PaymentsFactoryInterface { get }
}

public protocol PaymentsFactoryInterface {
    func make(entryPoint: PaymentsEntryPoint, onFinished: @escaping () -> Void) -> AnyView
}
