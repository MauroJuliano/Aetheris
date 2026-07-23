import Core
import Foundation

final class CoreServiceTestDouble: HasCoreService {
    struct Call: Equatable {
        let path: String
        let method: HTTPMethod
    }

    private(set) var calls: [Call] = []
    var responseData: Data?
    var error: Error?

    func execute<T>(_ endpoint: any Endpoint) async throws -> T where T: Decodable {
        calls.append(.init(path: endpoint.path, method: endpoint.method))

        if let error {
            throw error
        }

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
