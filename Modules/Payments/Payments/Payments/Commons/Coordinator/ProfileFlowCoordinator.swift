import Core
import SwiftUI

struct ProfileFlowCoordinator: View {
    let profileStore: ProfileStore
    let coreService: any HasCoreService

    var body: some View {
        ProfileScreenFactory.make(store: profileStore, coreService: coreService)
    }
}
