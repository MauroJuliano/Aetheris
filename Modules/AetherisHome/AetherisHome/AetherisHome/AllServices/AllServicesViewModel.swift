import Foundation

@MainActor
final class AllServicesViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var errorMessage: String?
    @Published private(set) var items: [AllServicesItem] = []

    private let service: any AllServicesServicing

    init(service: any AllServicesServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        items = await service.loadServices()

        isLoading = false
    }
}
