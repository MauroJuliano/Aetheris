import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var mockResponseData: Data { get }
}

public extension Endpoint {
    var mockResponseData: Data { Data() }
}
