import Core
import SwiftUI

enum NotificationsCentreFactory {
    @MainActor
    static func make(coreService: any HasCoreService,
                     onBack: @escaping () -> Void) -> NotificationsCentre {
        NotificationsCentre(
            viewModel: NotificationsCentreViewModel(service: NotificationsCentreService(coreService: coreService)),
            onBack: onBack
        )
    }
}
