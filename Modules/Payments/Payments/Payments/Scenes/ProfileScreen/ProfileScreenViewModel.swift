import AetherisDesignSystem
import Combine
import Foundation

@MainActor
final class ProfileScreenViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var profile: ProfileData

    private let store: ProfileStore

    init(store: ProfileStore) {
        self.store = store
        self.profile = store.profile
    }

    var generalCells: [FormCellModel] {
        profile.generalCells
    }

    func updateName(_ name: String) {
        store.profile.name = name
        profile = store.profile
    }

    func updateEmail(_ email: String) {
        store.profile.email = email
        profile = store.profile
    }

    func updatePhone(_ phone: String) {
        store.profile.phone = phone
        profile = store.profile
    }

    func load() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isLoading = false
    }
}
