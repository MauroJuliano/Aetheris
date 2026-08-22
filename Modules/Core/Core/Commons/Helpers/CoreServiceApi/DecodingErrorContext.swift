public struct DecodingErrorContext: Equatable, Sendable {
    public let type: String
    public let codingPath: String
    public let description: String

    public init(type: String, codingPath: String, description: String) {
        self.type = type
        self.codingPath = codingPath
        self.description = description
    }
}
