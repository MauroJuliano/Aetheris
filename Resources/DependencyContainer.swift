import Core
import Payments
import PaymentsInterface
import AERegistration
import AERegistrationInterface
import AetherisAuthentication
import AetherisAuthenticationInterface

@MainActor
final class DependencyContainer: HasRegistration,
                                 HasPayments {
    let coreService: any HasCoreService

    init(coreService: any HasCoreService = DemoCoreService()) {
        self.coreService = coreService
    }

    lazy var registrationFactory: RegistrationFactoryInterface = RegistrationFactory(coreService: coreService)
    lazy var paymentsFactory: PaymentsFactoryInterface = PaymentsFactory(coreService: coreService)
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(dependencies: self)
}
