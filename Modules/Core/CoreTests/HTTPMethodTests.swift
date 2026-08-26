import Testing
@testable import Core

@Suite("HTTPMethod")
struct HTTPMethodTests {
    @Test(arguments: [
        (HTTPMethod.get, "GET"),
        (HTTPMethod.post, "POST"),
        (HTTPMethod.put, "PUT"),
        (HTTPMethod.delete, "DELETE")
    ])
    func rawValue_matchesExpectedVerb(method: HTTPMethod, expected: String) {
        #expect(method.rawValue == expected)
    }
}
