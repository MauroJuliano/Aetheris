import Core
import Foundation

final class CoreServiceTestDouble: HasCoreService {
    struct Call: Equatable {
        let path: String
        let method: HTTPMethod
        let headers: [String: String]

        init(path: String, method: HTTPMethod, headers: [String: String] = [:]) {
            self.path = path
            self.method = method
            self.headers = headers
        }
    }

    private(set) var calls: [Call] = []
    var responseData: Data?
    var error: Error?

    func execute<T>(_ endpoint: any Endpoint) async throws -> T where T: Decodable {
        calls.append(.init(path: endpoint.path, method: endpoint.method, headers: endpoint.headers))

        if let error { throw error }

        let data = responseData ?? endpoint.mockResponseData
        guard !data.isEmpty else { throw CoreServiceError.invalidData }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CoreServiceError.invalidData
        }
    }
}
