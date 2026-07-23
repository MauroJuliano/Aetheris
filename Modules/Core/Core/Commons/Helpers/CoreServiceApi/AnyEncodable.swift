public struct AnyEncodable: Encodable {
    private let encodeClosure: (Encoder) throws -> Void
    
    public init(_ encodable: Encodable) {
        self.encodeClosure = encodable.encode
    }
    
    public func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}
