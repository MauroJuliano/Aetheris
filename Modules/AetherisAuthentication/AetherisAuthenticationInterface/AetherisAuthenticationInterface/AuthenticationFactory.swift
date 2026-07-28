import AERegistrationInterface
import PaymentsInterface
import AccountInterface
import Combine
import SwiftUI

public typealias AuthenticationDependencies = HasRegistration & HasPayments

@MainActor
public final class AppSessionStore: ObservableObject {
    @Published public var isAuthenticated = false

    public init() {}
}

public protocol AuthenticationFactoryInterface {
    init(dependencies: AuthenticationDependencies)
    func make() -> AnyView
}
