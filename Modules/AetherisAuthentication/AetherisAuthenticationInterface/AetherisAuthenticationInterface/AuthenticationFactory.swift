import AERegistrationInterface
import PaymentsInterface
import AccountInterface
import SwiftUI

public typealias AuthenticationDependencies = HasRegistration & HasPayments

public protocol AuthenticationFactoryInterface {
    init(dependencies: AuthenticationDependencies)
    func make() -> AnyView
}
