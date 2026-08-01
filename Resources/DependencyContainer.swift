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

    init(coreService: (any HasCoreService)? = nil) {
        self.coreService = coreService ?? Self.defaultCoreService()
    }

    private static func defaultCoreService() -> any HasCoreService {
        UITestConfiguration.isEnabled ? UITestCoreService() : DemoCoreService()
    }

    lazy var registrationFactory: RegistrationFactoryInterface = RegistrationFactory(coreService: coreService)
    lazy var paymentsFactory: PaymentsFactoryInterface = PaymentsFactory(coreService: coreService)
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(dependencies: self)
}
