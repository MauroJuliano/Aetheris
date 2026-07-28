import SwiftUI

enum ProfileScreenFactory {
    @MainActor
    static func make(store: ProfileStore) -> ProfileScreen {
        ProfileScreen(viewModel: ProfileScreenViewModel(store: store))
    }
}
