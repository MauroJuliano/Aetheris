import AetherisNotificationsInterface
import Core
import SwiftUI

public final class NotificationsFeatureFactory: NotificationsFactoryInterface {
    private let coreService: any HasCoreService

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    @MainActor
    public func make(
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            NotificationsCentreFactory.make(
                coreService: coreService,
                onBack: onBack
            )
        )
    }
}
