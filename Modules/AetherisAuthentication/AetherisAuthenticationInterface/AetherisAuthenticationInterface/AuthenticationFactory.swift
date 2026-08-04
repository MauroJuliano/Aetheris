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

public struct IdentityAuthorization: Codable, Hashable, Sendable {
    public let token: String
    public let expiresAt: String

    public init(token: String, expiresAt: String) {
        self.token = token
        self.expiresAt = expiresAt
    }
}

public struct IdentityValidationContent: Hashable, Sendable {
    public let navigationTitle: String
    public let title: String
    public let description: String

    public init(navigationTitle: String, title: String, description: String) {
        self.navigationTitle = navigationTitle
        self.title = title
        self.description = description
    }
}

public enum IdentityValidationResult: Equatable, Sendable {
    case authorized(IdentityAuthorization)
    case failed
}

public protocol IdentityValidating {
    @MainActor
    func authenticate(
        content: IdentityValidationContent,
        onCancel: @escaping () -> Void,
        onResult: @escaping (IdentityValidationResult) -> Void
    ) -> AnyView
}
