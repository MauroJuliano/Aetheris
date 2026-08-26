import Foundation

public enum NetworkError: Equatable, Sendable {
    case timedOut
    case noConnection
    case cancelled
    case connectionLost
    case other(code: Int)
}

public enum CoreServiceError: Error, Equatable {
    case invalidData
    case invalidResponse
    case invalidUrl
    case encoding
    case network(NetworkError)
    case decoding(DecodingErrorContext)
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
        case .invalidData, .invalidResponse, .invalidUrl, .encoding, .network, .decoding:
            return nil
        }
    }

    var serverMessage: String? {
        context?.message
    }
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
        session: URLSession? = nil
    ) {
        self.configuration = configuration
        self.session = session ?? configuration.makeSession()
    }

    public func execute<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        guard configuration.baseURL.scheme?.lowercased() == "https",
              endpoint.path.hasPrefix("/"),
              let url = URL(string: endpoint.path, relativeTo: configuration.baseURL)?.absoluteURL else {
            throw CoreServiceError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        configuration.defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        endpoint.headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let body = endpoint.body {
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            do {
                request.httpBody = try JSONEncoder().encode(AnyEncodable(body))
            } catch {
                throw CoreServiceError.encoding
            }
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError {
            throw CoreServiceError.network(Self.networkError(for: error))
        } catch {
            throw CoreServiceError.invalidResponse
        }
        
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
            throw CoreServiceError.decoding(Self.decodingContext(for: error, type: T.self))
        }
    }

    private static func networkError(for error: URLError) -> NetworkError {
        switch error.code {
        case .timedOut:
            return .timedOut
        case .notConnectedToInternet:
            return .noConnection
        case .cancelled:
            return .cancelled
        case .networkConnectionLost:
            return .connectionLost
        default:
            return .other(code: error.errorCode)
        }
    }

    private static func decodingContext<T>(for error: Error, type: T.Type) -> DecodingErrorContext {
        let context: DecodingError.Context?
        let description: String

        switch error {
        case let DecodingError.dataCorrupted(value):
            context = value
            description = value.debugDescription
        case let DecodingError.keyNotFound(key, value):
            context = value
            description = "Missing key: \(key.stringValue). \(value.debugDescription)"
        case let DecodingError.typeMismatch(_, value):
            context = value
            description = value.debugDescription
        case let DecodingError.valueNotFound(_, value):
            context = value
            description = value.debugDescription
        default:
            context = nil
            description = String(describing: error)
        }

        let codingPath = context?.codingPath.map(\.stringValue).joined(separator: ".") ?? ""
        return DecodingErrorContext(
            type: String(reflecting: type),
            codingPath: codingPath,
            description: description
        )
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
