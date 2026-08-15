import Core
import Account
import AccountInterface
import AetherisCards
import AetherisCardsInterface
import AetherisHome
import AetherisHomeInterface
import AetherisTransfers
import AetherisTransfersInterface
import AERegistration
import AERegistrationInterface
import AetherisAuthentication
import AetherisAuthenticationInterface

@MainActor
final class DependencyContainer: HasRegistration,
                                 HasHome,
                                 HasCards,
                                 HasTransfers,
                                 HasAccount {
    let coreService: any HasCoreService

    init(coreService: (any HasCoreService)? = nil) {
        self.coreService = coreService ?? Self.defaultCoreService()
    }

    private static func defaultCoreService() -> any HasCoreService {
        UITestConfiguration.isEnabled ? UITestCoreService() : DemoCoreService()
    }

    lazy var registrationFactory: RegistrationFactoryInterface = RegistrationFactory(coreService: coreService)
    lazy var identityValidation: IdentityValidating = IdentityValidationFactory(coreService: coreService)
    lazy var homeFactory: HomeFactoryInterface = HomeFactory(
        coreService: coreService,
        identityValidation: identityValidation
    )
    lazy var cardsFactory: CardsFactoryInterface = CardsFactory(coreService: coreService)
    lazy var transfersFactory: TransfersFactoryInterface = TransfersFeatureFactory(
        coreService: coreService,
        identityValidation: identityValidation
    )
    lazy var accountFactory: AccountFactoryInterface = AccountFactory(coreService: coreService)
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(dependencies: self)
}
