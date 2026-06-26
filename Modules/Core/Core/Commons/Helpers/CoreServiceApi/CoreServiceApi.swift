import Foundation

enum RegisterError: Error {
    case invalidData
    case invalidResponse
    case invalidUrl
}

protocol HasCoreService {
    func execute<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class CoreServiceApi: HasCoreService {
    func execute<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        guard let url = URL(string: endpoint.path) else { throw RegisterError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RegisterError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw RegisterError.invalidData
        }
    }
}
