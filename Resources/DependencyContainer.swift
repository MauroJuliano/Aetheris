import Core
import Payments
import PaymentsInterface
import AERegistration
import AERegistrationInterface
import AetherisAuthentication
import AetherisAuthenticationInterface

final class DependencyContainer: HasRegistration,
                                 HasPayments {
    lazy var coreService: any HasCoreService = MockCoreServiceApi()
    lazy var registrationFactory: RegistrationFactoryInterface = RegistrationFactory(coreService: coreService)
    lazy var paymentsFactory: PaymentsFactoryInterface = PaymentsFactory(coreService: coreService)
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(dependencies: self)
}
