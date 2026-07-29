import SwiftUI

struct ProfileFlowCoordinator: View {
    let profileStore: ProfileStore

    var body: some View {
        ProfileScreenFactory.make(store: profileStore)
    }
}
