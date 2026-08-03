import Foundation

public struct HTTPErrorContext: Equatable, Sendable {
    public let statusCode: Int
    public let code: String?
    public let message: String?

    public init(statusCode: Int, code: String? = nil, message: String? = nil) {
        self.statusCode = statusCode
        self.code = code
        self.message = message
    }
}

public enum CoreServiceError: Error, Equatable {
    case invalidData
    case invalidResponse
    case invalidUrl
    case badRequest(HTTPErrorContext)
    case unauthorized(HTTPErrorContext)
    case forbidden(HTTPErrorContext)
    case notFound(HTTPErrorContext)
    case serverError(HTTPErrorContext)
    case httpError(HTTPErrorContext)
}

public extension CoreServiceError {
    var context: HTTPErrorContext? {
        switch self {
        case let .badRequest(context),
             let .unauthorized(context),
             let .forbidden(context),
             let .notFound(context),
             let .serverError(context),
             let .httpError(context):
            return context
        case .invalidData, .invalidResponse, .invalidUrl:
            return nil
        }
    }

    var serverMessage: String? {
        context?.message
    }
}

public struct EmptyResponse: Codable, Equatable, Sendable {
    public init() {}
}

public protocol HasCoreService {
    func execute<T: Decodable>(_ endpoint: any Endpoint) async throws -> T
}

public extension HasCoreService {
    func execute(_ endpoint: any Endpoint) async throws {
        let _: EmptyResponse = try await execute(endpoint)
    }
}

public final class CoreServiceApi: HasCoreService {
    private let configuration: APIConfiguration
    private let session: URLSession

    public init(
        configuration: APIConfiguration = .demo,
        session: URLSession = .shared
    ) {
        self.configuration = configuration
        self.session = session
    }

    public func execute<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        guard endpoint.path.hasPrefix("/"),
              let url = URL(string: endpoint.path, relativeTo: configuration.baseURL)?.absoluteURL else {
            throw CoreServiceError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw CoreServiceError.invalidResponse
        }

        guard (200..<300).contains(response.statusCode) else {
            throw Self.serviceError(statusCode: response.statusCode, data: data)
        }

        if data.isEmpty {
            guard let emptyResponse = EmptyResponse() as? T else {
                throw CoreServiceError.invalidData
            }
            return emptyResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CoreServiceError.invalidData
        }
    }

    private static func serviceError(statusCode: Int, data: Data) -> CoreServiceError {
        let payload = try? JSONDecoder().decode(BackendErrorPayload.self, from: data)
        let context = HTTPErrorContext(
            statusCode: statusCode,
            code: payload?.code,
            message: payload?.resolvedMessage
        )

        switch statusCode {
        case 400:
            return .badRequest(context)
        case 401:
            return .unauthorized(context)
        case 403:
            return .forbidden(context)
        case 404:
            return .notFound(context)
        case 500...599:
            return .serverError(context)
        default:
            return .httpError(context)
        }
    }
}

private struct BackendErrorPayload: Decodable {
    let code: String?
    let message: String?
    let error: String?

    var resolvedMessage: String? { message ?? error }
}

public final class DemoCoreService: HasCoreService {
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
