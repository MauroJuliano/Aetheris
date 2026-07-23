import Foundation

public enum CoreServiceError: Error {
    case invalidData
    case invalidResponse
    case invalidUrl
}

public protocol HasCoreService {
    func execute<T: Decodable>(_ endpoint: any Endpoint) async throws -> T
}

public final class CoreServiceApi: HasCoreService {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func execute<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        guard let url = URL(string: endpoint.path) else { throw CoreServiceError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CoreServiceError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CoreServiceError.invalidData
        }
    }
}

public final class MockCoreServiceApi: HasCoreService {
    public init(delay: TimeInterval = 0.9) {
        self.delay = delay
    }

    private let delay: TimeInterval

    public func execute<T>(_ endpoint: any Endpoint) async throws -> T where T: Decodable {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))

        let data = endpoint.mockResponseData
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
