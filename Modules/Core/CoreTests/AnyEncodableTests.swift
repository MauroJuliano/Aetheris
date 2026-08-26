import Foundation
import Testing
@testable import Core

@Suite("AnyEncodable")
struct AnyEncodableTests {
    @Test
    func encodesUnderlyingValue() throws {
        let wrapped = AnyEncodable(Payload(value: "ok"))
        let data = try JSONEncoder().encode(wrapped)
        let decoded = try JSONDecoder().decode(Payload.self, from: data)

        #expect(decoded == Payload(value: "ok"))
    }
}

private struct Payload: Codable, Equatable {
    let value: String
}
