protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
}
