import Foundation
import Testing
@testable import Core

@Suite("CoreServiceApi")
struct CoreServiceApiTests {
    @Test
    func execute_decodesResponse_andBuildsRequest() async throws {
        let url = makeURL()
        URLProtocolSpy.register(
            response: .init(statusCode: 200, data: try JSONEncoder().encode(Payload(value: "ok"))),
            for: url
        )

        let sut = CoreServiceApi(session: makeSession())
        let expectedBody = try JSONEncoder().encode(Body(value: "dummy"))

        let result: Payload = try await sut.execute(TestEndpoint(url: url, body: Body(value: "dummy")))

        #expect(result == Payload(value: "ok"))
        #expect(URLProtocolSpy.request(for: url)?.httpMethod == HTTPMethod.post.rawValue)
        #expect(URLProtocolSpy.request(for: url)?.value(forHTTPHeaderField: "Content-Type") == "application/json")
        #expect(URLProtocolSpy.body(for: url) == expectedBody)
    }

    @Test
    func execute_combinesInjectedBaseURLWithRelativeEndpointPath() async throws {
        let baseURL = URL(string: "https://staging.aetheris.app")!
        let path = "/custom/resource?source=test"
        let expectedURL = URL(string: path, relativeTo: baseURL)!.absoluteURL
        URLProtocolSpy.register(
            response: .init(statusCode: 200, data: try JSONEncoder().encode(Payload(value: "ok"))),
            for: expectedURL
        )
        let sut = CoreServiceApi(
            configuration: APIConfiguration(baseURL: baseURL),
            session: makeSession()
        )

        let result: Payload = try await sut.execute(TestEndpoint(path: path, body: nil))

        #expect(result == Payload(value: "ok"))
        #expect(URLProtocolSpy.request(for: expectedURL)?.url == expectedURL)
    }

    @Test
    func configuration_buildsSessionWithExplicitTimeouts() {
        let configuration = APIConfiguration(
            baseURL: URL(string: "https://api.aetheris.app")!,
            requestTimeout: 12,
            resourceTimeout: 45
        )

        let sessionConfiguration = configuration.makeSessionConfiguration()

        #expect(sessionConfiguration.timeoutIntervalForRequest == 12)
        #expect(sessionConfiguration.timeoutIntervalForResource == 45)
        #expect(sessionConfiguration.requestCachePolicy == .reloadIgnoringLocalCacheData)
        #expect(!sessionConfiguration.httpShouldSetCookies)
        #expect(sessionConfiguration.httpCookieStorage == nil)
        #expect(sessionConfiguration.urlCredentialStorage == nil)
        #expect(sessionConfiguration.urlCache == nil)
    }

    @Test
    func execute_mergesDefaultAndEndpointHeaders_withEndpointTakingPrecedence() async throws {
        let url = makeURL()
        URLProtocolSpy.register(
            response: .init(statusCode: 200, data: try JSONEncoder().encode(Payload(value: "ok"))),
            for: url
        )
        let configuration = APIConfiguration(
            baseURL: URL(string: "https://api.aetheris.app")!,
            defaultHeaders: ["Accept": "application/json", "X-Source": "global"]
        )
        let sut = CoreServiceApi(configuration: configuration, session: makeSession())
        let endpoint = TestEndpoint(
            url: url,
            body: nil,
            headers: ["X-Source": "endpoint", "Idempotency-Key": "transfer-1"]
        )

        let _: Payload = try await sut.execute(endpoint)

        let request = URLProtocolSpy.request(for: url)
        #expect(request?.value(forHTTPHeaderField: "Accept") == "application/json")
        #expect(request?.value(forHTTPHeaderField: "X-Source") == "endpoint")
        #expect(request?.value(forHTTPHeaderField: "Idempotency-Key") == "transfer-1")
    }

    @Test
    func execute_throwsInvalidUrl_forBadPath() async throws {
        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint.invalidURL)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidUrl)
        }
    }

    @Test
    func execute_rejectsInsecureBaseURL() async {
        let configuration = APIConfiguration(baseURL: URL(string: "http://api.aetheris.app")!)
        let sut = CoreServiceApi(configuration: configuration, session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(path: "/registration/password", body: nil))
            Issue.record("Expected insecure URL to be rejected")
        } catch {
            #expect((error as? CoreServiceError) == .invalidUrl)
        }
    }

    @Test(arguments: [201, 202])
    func execute_acceptsCreatedAndAcceptedResponses(statusCode: Int) async throws {
        let url = makeURL()
        URLProtocolSpy.register(
            response: .init(statusCode: statusCode, data: try JSONEncoder().encode(Payload(value: "ok"))),
            for: url
        )
        let sut = CoreServiceApi(session: makeSession())

        let result: Payload = try await sut.execute(TestEndpoint(url: url, body: nil))

        #expect(result == .init(value: "ok"))
    }

    @Test
    func execute_returnsEmptyResponse_forNoContent() async throws {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 204, data: nil), for: url)
        let sut = CoreServiceApi(session: makeSession())

        let result: EmptyResponse = try await sut.execute(TestEndpoint(url: url, body: nil))

        #expect(result == EmptyResponse())
    }

    @Test
    func execute_withoutReturnType_acceptsNoContent() async throws {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 204, data: nil), for: url)
        let sut = CoreServiceApi(session: makeSession())

        try await sut.execute(TestEndpoint(url: url, body: nil))
    }

    @Test
    func execute_throwsInvalidData_whenNoContentExpectsPayload() async {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 204, data: nil), for: url)
        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: nil))
            Issue.record("Expected request to throw")
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    @Test
    func execute_mapsURLErrorToNetworkError() async {
        let url = makeURL()
        URLProtocolSpy.register(error: URLError(.notConnectedToInternet), for: url)
        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: nil))
            Issue.record("Expected request to throw")
        } catch {
            #expect((error as? CoreServiceError) == .network(.noConnection))
        }
    }

    @Test
    func execute_mapsBodyEncodingFailure() async {
        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(path: "/encoding", body: FailingBody()))
            Issue.record("Expected request to throw")
        } catch {
            #expect((error as? CoreServiceError) == .encoding)
        }
    }

    @Test(arguments: HTTPErrorCase.allCases)
    func execute_mapsKnownHTTPErrorStatuses(testCase: HTTPErrorCase) async throws {
        let url = makeURL()
        let backendError = BackendError(code: "request_failed", message: "Request failed")
        URLProtocolSpy.register(
            response: .init(statusCode: testCase.statusCode, data: try JSONEncoder().encode(backendError)),
            for: url
        )

        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: Body(value: "dummy")))
            Issue.record("Expected request to throw")
        } catch {
            let context = HTTPErrorContext(
                statusCode: testCase.statusCode,
                code: "request_failed",
                message: "Request failed"
            )
            #expect((error as? CoreServiceError) == testCase.expectedError(context: context))
        }
    }

    @Test
    func execute_mapsUnexpectedHTTPStatusToGenericHTTPError() async {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 418, data: nil), for: url)
        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: nil))
            Issue.record("Expected request to throw")
        } catch {
            #expect(
                (error as? CoreServiceError) == .httpError(
                    .init(statusCode: 418)
                )
            )
        }
    }

    @Test
    func serviceError_exposesSharedContextAndServerMessage() {
        let context = HTTPErrorContext(
            statusCode: 400,
            code: "invalid_field",
            message: "The field is invalid"
        )
        let sut = CoreServiceError.badRequest(context)

        #expect(sut.context == context)
        #expect(sut.serverMessage == "The field is invalid")
        #expect(CoreServiceError.network(.timedOut).context == nil)
        #expect(CoreServiceError.decoding(.init(type: "Payload", codingPath: "value", description: "Invalid")).serverMessage == nil)
    }

    @Test
    func execute_preservesContext_forMalformedResponse() async throws {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 200, data: Data("{}".utf8)), for: url)

        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: Body(value: "dummy")))
            #expect(Bool(false))
        } catch {
            guard case let .decoding(context) = error as? CoreServiceError else {
                Issue.record("Expected decoding error")
                return
            }
            #expect(context.type.contains("Payload"))
            #expect(context.codingPath.isEmpty)
            #expect(context.description.contains("value"))
        }
    }

    private func makeURL() -> URL {
        URL(string: "https://api.aetheris.app/test/\(UUID().uuidString)")!
    }

    private func makeSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolSpy.self]
        return URLSession(configuration: configuration)
    }
}

private struct TestEndpoint: Endpoint {
    static let invalidURL = TestEndpoint(path: "", body: nil)

    let path: String
    let body: Encodable?
    let headers: [String: String]

    init(url: URL, body: Encodable?, headers: [String: String] = [:]) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let query = components?.percentEncodedQuery.map { "?\($0)" } ?? ""
        self.path = url.path + query
        self.body = body
        self.headers = headers
    }

    init(path: String, body: Encodable?, headers: [String: String] = [:]) {
        self.path = path
        self.body = body
        self.headers = headers
    }

    var method: HTTPMethod { .post }
    var mockResponseData: Data { Data() }
}

private struct Body: Encodable, Equatable {
    let value: String
}

private struct FailingBody: Encodable {
    func encode(to encoder: Encoder) throws {
        throw EncodingFailure.expected
    }
}

private enum EncodingFailure: Error {
    case expected
}

private struct Payload: Codable, Equatable {
    let value: String
}

private struct BackendError: Encodable {
    let code: String
    let message: String
}

enum HTTPErrorCase: CaseIterable {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError

    var statusCode: Int {
        switch self {
        case .badRequest: 400
        case .unauthorized: 401
        case .forbidden: 403
        case .notFound: 404
        case .internalServerError: 500
        }
    }

    func expectedError(context: HTTPErrorContext) -> CoreServiceError {
        switch self {
        case .badRequest: .badRequest(context)
        case .unauthorized: .unauthorized(context)
        case .forbidden: .forbidden(context)
        case .notFound: .notFound(context)
        case .internalServerError: .serverError(context)
        }
    }
}

private struct SpyResponse {
    let statusCode: Int
    let data: Data?
}

private final class URLProtocolSpy: URLProtocol {
    private static let lock = NSLock()
    private static var responses: [URL: SpyResponse] = [:]
    private static var errors: [URL: Error] = [:]
    private static var requests: [URL: URLRequest] = [:]
    private static var bodies: [URL: Data] = [:]

    static func register(response: SpyResponse, for url: URL) {
        lock.lock()
        responses[url] = response
        lock.unlock()
    }

    static func register(error: Error, for url: URL) {
        lock.lock()
        errors[url] = error
        lock.unlock()
    }

    static func request(for url: URL) -> URLRequest? {
        lock.lock()
        defer { lock.unlock() }
        return requests[url]
    }

    static func body(for url: URL) -> Data? {
        lock.lock()
        defer { lock.unlock() }
        return bodies[url]
    }

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let url = request.url else {
            client?.urlProtocol(self, didFailWithError: CoreServiceError.invalidUrl)
            return
        }

        let response = Self.response(for: url) ?? SpyResponse(statusCode: 200, data: nil)

        Self.lock.lock()
        Self.requests[url] = request
        Self.bodies[url] = request.httpBody ?? Self.data(from: request.httpBodyStream)
        Self.lock.unlock()

        if let error = Self.error(for: url) {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: response.statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: nil
        )!

        client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)

        if let data = response.data {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    private static func response(for url: URL) -> SpyResponse? {
        lock.lock()
        defer { lock.unlock() }
        return responses[url]
    }

    private static func error(for url: URL) -> Error? {
        lock.lock()
        defer { lock.unlock() }
        return errors.removeValue(forKey: url)
    }

    private static func data(from stream: InputStream?) -> Data? {
        guard let stream else { return nil }
        stream.open()
        defer { stream.close() }

        let bufferSize = 4096
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        let data = NSMutableData()

        while stream.hasBytesAvailable {
            let read = stream.read(&buffer, maxLength: bufferSize)
            if read < 0 { return nil }
            if read == 0 { break }
            data.append(buffer, length: read)
        }

        return data as Data
    }
}
