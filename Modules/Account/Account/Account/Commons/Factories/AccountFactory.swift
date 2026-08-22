import AccountInterface
import Core
import SwiftUI

@MainActor
public final class AccountFactory: AccountFactoryInterface {
    private let coreService: any HasCoreService
    private let languageManager: any LanguageManaging
    private let profileStore = ProfileStore()

    public init(
        coreService: any HasCoreService,
        languageManager: any LanguageManaging = LanguageManager()
    ) {
        self.coreService = coreService
        self.languageManager = languageManager
    }

    public func make(
        entryPoint: AccountEntryPoint,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        switch entryPoint {
        case .profile:
            AnyView(ProfileScreenFactory.make(
                store: profileStore,
                coreService: coreService,
                languageManager: languageManager
            ))
        @unknown default:
            AnyView(EmptyView())
        }
    }
}
