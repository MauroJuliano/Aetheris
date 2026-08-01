import Core
import Foundation

enum UITestConfiguration {
    static let isEnabled = ProcessInfo.processInfo.arguments.contains("-uiTesting")
    static let startsAuthenticated = ProcessInfo.processInfo.arguments.contains("-uiTestingAuthenticated")
    static let failsHomeOnce = ProcessInfo.processInfo.arguments.contains("-uiTestingHomeFailureOnce")
}

final class UITestCoreService: HasCoreService, @unchecked Sendable {
    private let demo = DemoCoreService(delay: 0.05)
    private let lock = NSLock()
    private var didFailHome = false

    func execute<T>(_ endpoint: any Endpoint) async throws -> T where T: Decodable {
        if UITestConfiguration.failsHomeOnce, endpoint.path.hasSuffix("/payments/home/dashboard"), shouldFailHome() {
            throw CoreServiceError.serverError(
                .init(statusCode: 500, code: "UI_TEST", message: "Simulated home failure")
            )
        }

        return try await demo.execute(endpoint)
    }

    private func shouldFailHome() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        guard !didFailHome else { return false }
        didFailHome = true
        return true
    }
}
