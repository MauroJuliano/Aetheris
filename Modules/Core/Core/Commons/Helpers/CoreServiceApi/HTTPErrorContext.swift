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
