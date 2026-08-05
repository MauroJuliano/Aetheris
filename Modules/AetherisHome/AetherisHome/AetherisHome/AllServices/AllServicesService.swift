import Foundation

protocol AllServicesServicing {
    func loadServices() async -> [AllServicesItem]
}

final class AllServicesService: AllServicesServicing {
    func loadServices() async -> [AllServicesItem] {
        AllServicesFixtures.items
    }
}
