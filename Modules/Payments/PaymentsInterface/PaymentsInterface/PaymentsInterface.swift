import SwiftUI

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
