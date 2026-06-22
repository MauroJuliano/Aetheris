import Payments
import PaymentsInterface
import AERegistration
import AERegistrationInterface
import AetherisAuthentication
import AetherisAuthenticationInterface

final class DependencyContainer: HasRegistration,
                                 HasPayments {
    lazy var registrationFactory: RegistrationFactoryInterface = RegistrationFactory()
    lazy var paymentsFactory: PaymentsFactoryInterface = PaymentsFactory()
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(dependencies: self)
}
