import Core
import SwiftUI

enum ProfileScreenFactory {
    @MainActor
    static func make(
        store: ProfileStore,
        coreService: any HasCoreService,
        languageManager: any LanguageManaging
    ) -> ProfileScreen {
        ProfileScreen(
            viewModel: ProfileScreenViewModel(
                store: store,
                service: ProfileService(coreService: coreService)
            ),
            languageManager: languageManager
        )
    }
}
