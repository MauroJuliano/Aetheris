import SwiftUI

enum ProfileScreenFactory {
    @MainActor
    static func make() -> ProfileScreen {
        ProfileScreen(viewModel: ProfileScreenViewModel())
    }
}
