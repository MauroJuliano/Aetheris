import Foundation

public struct APIConfiguration: Sendable {
    public let baseURL: URL
    public let requestTimeout: TimeInterval
    public let resourceTimeout: TimeInterval
    public let defaultHeaders: [String: String]

    public init(
        baseURL: URL,
        requestTimeout: TimeInterval = 30,
        resourceTimeout: TimeInterval = 60,
        defaultHeaders: [String: String] = ["Accept": "application/json"]
    ) {
        self.baseURL = baseURL
        self.requestTimeout = requestTimeout
        self.resourceTimeout = resourceTimeout
        self.defaultHeaders = defaultHeaders
    }

    public static let demo = APIConfiguration(
        baseURL: URL(string: "https://api.aetheris.app")!
    )

    func makeSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = requestTimeout
        configuration.timeoutIntervalForResource = resourceTimeout
        return URLSession(configuration: configuration)
    }
}
