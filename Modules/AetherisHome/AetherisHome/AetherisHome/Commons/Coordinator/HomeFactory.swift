import AetherisHomeInterface
import AetherisAuthenticationInterface
import AetherisInsightsInterface
import AetherisNotificationsInterface
import Core
import SwiftUI

public final class HomeFactory: HomeFactoryInterface {
    private let coreService: any HasCoreService
    private let identityValidation: any IdentityValidating
    private let insightsFactory: InsightsFactoryInterface
    private let notificationsFactory: NotificationsFactoryInterface

    public init(
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating,
        insightsFactory: InsightsFactoryInterface,
        notificationsFactory: NotificationsFactoryInterface
    ) {
        self.coreService = coreService
        self.identityValidation = identityValidation
        self.insightsFactory = insightsFactory
        self.notificationsFactory = notificationsFactory
    }

    @MainActor public func make() -> AnyView {
        AnyView(HomeFlowCoordinator(
            coreService: coreService,
            identityValidation: identityValidation,
            insightsFactory: insightsFactory,
            notificationsFactory: notificationsFactory
        ))
    }
}
