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
    func execute_throwsInvalidResponse_forNon200Status() async throws {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 500, data: nil), for: url)

        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: Body(value: "dummy")))
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidResponse)
        }
    }

    @Test
    func execute_throwsInvalidData_forMalformedResponse() async throws {
        let url = makeURL()
        URLProtocolSpy.register(response: .init(statusCode: 200, data: Data("{}".utf8)), for: url)

        let sut = CoreServiceApi(session: makeSession())

        do {
            let _: Payload = try await sut.execute(TestEndpoint(url: url, body: Body(value: "dummy")))
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
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

    init(url: URL, body: Encodable?) {
        self.path = url.absoluteString
        self.body = body
    }

    init(path: String, body: Encodable?) {
        self.path = path
        self.body = body
    }

    var method: HTTPMethod { .post }
    var mockResponseData: Data { Data() }
}

private struct Body: Encodable, Equatable {
    let value: String
}

private struct Payload: Codable, Equatable {
    let value: String
}

private struct SpyResponse {
    let statusCode: Int
    let data: Data?
}

private final class URLProtocolSpy: URLProtocol {
    private static let lock = NSLock()
    private static var responses: [URL: SpyResponse] = [:]
    private static var requests: [URL: URLRequest] = [:]
    private static var bodies: [URL: Data] = [:]

    static func register(response: SpyResponse, for url: URL) {
        lock.lock()
        responses[url] = response
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
