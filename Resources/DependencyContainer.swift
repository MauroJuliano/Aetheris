import Core
import Account
import AccountInterface
import AetherisCards
import AetherisCardsInterface
import AetherisInsights
import AetherisInsightsInterface
import AetherisHome
import AetherisHomeInterface
import AetherisNotifications
import AetherisNotificationsInterface
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
                                 HasInsights,
                                 HasNotifications,
                                 HasTransfers,
                                 HasAccount {
    let coreService: any HasCoreService
    let languageManager: any LanguageManaging

    init(coreService: (any HasCoreService)? = nil) {
        self.coreService = coreService ?? Self.defaultCoreService()
        self.languageManager = LanguageManager()
    }

    private static func defaultCoreService() -> any HasCoreService {
        UITestConfiguration.isEnabled ? UITestCoreService() : DemoCoreService()
    }

    lazy var registrationFactory: RegistrationFactoryInterface = RegistrationFactory(coreService: coreService)
    lazy var identityValidation: IdentityValidating = IdentityValidationFactory(coreService: coreService)
    lazy var homeFactory: HomeFactoryInterface = HomeFactory(
        coreService: coreService,
        identityValidation: identityValidation,
        insightsFactory: insightsFactory,
        notificationsFactory: notificationsFactory
    )
    lazy var cardsFactory: CardsFactoryInterface = CardsFactory(coreService: coreService)
    lazy var insightsFactory: InsightsFactoryInterface = InsightsFeatureFactory(
        coreService: coreService
    )
    lazy var notificationsFactory: NotificationsFactoryInterface = NotificationsFeatureFactory(
        coreService: coreService
    )
    lazy var transfersFactory: TransfersFactoryInterface = TransfersFeatureFactory(
        coreService: coreService,
        identityValidation: identityValidation
    )
    lazy var accountFactory: AccountFactoryInterface = AccountFactory(
        coreService: coreService,
        languageManager: languageManager
    )
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(dependencies: self)
}
