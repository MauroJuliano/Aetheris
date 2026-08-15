import AccountInterface
import Core
import SwiftUI

@MainActor
public final class AccountFactory: AccountFactoryInterface {
    private let coreService: any HasCoreService
    private let profileStore = ProfileStore()

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    public func make(
        entryPoint: AccountEntryPoint,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        switch entryPoint {
        case .profile:
            AnyView(ProfileScreenFactory.make(store: profileStore, coreService: coreService))
        @unknown default:
            AnyView(EmptyView())
        }
    }
}
