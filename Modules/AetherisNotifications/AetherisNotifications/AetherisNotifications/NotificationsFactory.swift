import Core
import SwiftUI

public enum NotificationsFactory {
    @MainActor
    public static func make(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(NotificationsCentreFactory.make(coreService: coreService, onBack: onBack))
    }
}
