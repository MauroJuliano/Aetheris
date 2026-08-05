import AERegistrationInterface
import AccountInterface
import AetherisCardsInterface
import AetherisHomeInterface
import AetherisTransfersInterface
import Combine
import SwiftUI

public typealias AuthenticationDependencies = HasRegistration & HasHome & HasCards & HasTransfers & HasAccount

@MainActor
public final class AppSessionStore: ObservableObject {
    @Published public var isAuthenticated = false

    public init() {}
}

@MainActor
public final class TabBarVisibilityStore: ObservableObject {
    @Published public var isVisible = true
    public init() {}
}

public protocol AuthenticationFactoryInterface {
    init(dependencies: AuthenticationDependencies)
    func make() -> AnyView
}
