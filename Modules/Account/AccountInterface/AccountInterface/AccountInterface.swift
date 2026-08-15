import SwiftUI

public enum AccountEntryPoint {
    case profile
}

@MainActor
public protocol HasAccount {
    var accountFactory: AccountFactoryInterface { get }
}

@MainActor
public protocol AccountFactoryInterface {
    func make(entryPoint: AccountEntryPoint, onFinished: @escaping () -> Void) -> AnyView
}
