import Foundation

public struct APIConfiguration: Sendable {
    public let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public static let demo = APIConfiguration(
        baseURL: URL(string: "https://api.aetheris.app")!
    )
}
