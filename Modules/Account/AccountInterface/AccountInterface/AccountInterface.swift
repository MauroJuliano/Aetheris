import SwiftUI

public enum AccountEntryPoint {
    case profile
}

public protocol HasAccount {
    var accountFactory: AccountFactoryInterface { get }
}

public protocol AccountFactoryInterface {
    func make(entryPoint: AccountEntryPoint, onFinished: @escaping () -> Void) -> AnyView
}
