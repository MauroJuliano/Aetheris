struct AnyEncodable: Encodable {
    private let encodeClosure: (Encoder) throws -> Void
    
    init(_ encodable: Encodable) {
        self.encodeClosure = encodable.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}
