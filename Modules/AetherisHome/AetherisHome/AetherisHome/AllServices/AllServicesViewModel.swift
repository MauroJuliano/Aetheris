import Foundation

@MainActor
final class AllServicesViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var errorMessage: String?
    @Published private(set) var items: [AllServicesItem] = []

    private let service: any AllServicesServicing

    var displayedItems: [AllServicesItem] {
        guard isLoading else { return items }
        return (0..<6).map { _ in
            AllServicesItem(title: "Loading", subtitle: "Loading", icon: "square.grid.2x2", theme: .primary, route: .transfer)
        }
    }

    init(service: any AllServicesServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            items = try await service.loadServices()
        } catch {
            items = []
            errorMessage = Strings.HomeApp.genericErrorDescription
        }

        isLoading = false
    }
}
