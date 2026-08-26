import Core
import Foundation

enum HomeAppEndpoint {
    case dashboard
}

extension HomeAppEndpoint: Endpoint {
    var path: String { "/payments/home/dashboard" }
    var method: HTTPMethod { .get }
    var body: Encodable? { nil }

    var mockResponseData: Data {
        Self.encodeOrEmpty(HomeAppDashboard.mock)
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
