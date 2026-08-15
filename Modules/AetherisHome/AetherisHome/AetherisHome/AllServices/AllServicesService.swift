import Core
import Foundation

protocol AllServicesServicing {
    func loadServices() async throws -> [AllServicesItem]
}

final class AllServicesService: AllServicesServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadServices() async throws -> [AllServicesItem] {
        try await coreService.execute(AllServicesEndpoint.list)
    }
}

private enum AllServicesEndpoint {
    case list
}

extension AllServicesEndpoint: Endpoint {
    var path: String {
        "/payments/services"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .list:
            return Self.encodeOrEmpty(AllServicesFixtures.items)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
