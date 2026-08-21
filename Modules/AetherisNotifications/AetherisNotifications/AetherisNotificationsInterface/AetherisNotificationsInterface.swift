import SwiftUI

@MainActor
public protocol HasNotifications {
    var notificationsFactory: NotificationsFactoryInterface { get }
}

@MainActor
public protocol NotificationsFactoryInterface {
    func make(
        onBack: @escaping () -> Void
    ) -> AnyView
}
