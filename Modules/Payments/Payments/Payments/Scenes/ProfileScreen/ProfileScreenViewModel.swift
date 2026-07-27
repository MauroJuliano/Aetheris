import Foundation

@MainActor
final class ProfileScreenViewModel: ObservableObject {
    @Published private(set) var isLoading = true

    func load() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isLoading = false
    }
}
