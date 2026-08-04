import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    var mockResponseData: Data { get }
}

public extension Endpoint {
    var headers: [String: String] { [:] }
    var mockResponseData: Data { Data() }
}
