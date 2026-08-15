import Core
import Foundation

enum UITestConfiguration {
    static let isEnabled = ProcessInfo.processInfo.arguments.contains("-uiTesting")
    static let startsAuthenticated = ProcessInfo.processInfo.arguments.contains("-uiTestingAuthenticated")
    static let failsHomeOnce = ProcessInfo.processInfo.arguments.contains("-uiTestingHomeFailureOnce")
    static let failsTransferOnce = ProcessInfo.processInfo.arguments.contains("-uiTestingTransferFailureOnce")
}

final class UITestCoreService: HasCoreService, @unchecked Sendable {
    private let demo = DemoCoreService(delay: 0.05)
    private let lock = NSLock()
    private var didFailHome = false
    private var didFailTransfer = false

    func execute<T>(_ endpoint: any Endpoint) async throws -> T where T: Decodable {
        if UITestConfiguration.failsHomeOnce, endpoint.path.hasSuffix("/payments/home/dashboard"), shouldFailHome() {
            throw CoreServiceError.serverError(
                .init(statusCode: 500, code: "UI_TEST", message: "Simulated home failure")
            )
        }

        if endpoint.path == "/payments/transfers" {
            try await Task.sleep(for: .milliseconds(900))
            if UITestConfiguration.failsTransferOnce, shouldFailTransfer() {
                throw CoreServiceError.serverError(
                    .init(statusCode: 500, code: "UI_TEST", message: "Simulated transfer failure")
                )
            }
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

    private func shouldFailTransfer() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        guard !didFailTransfer else { return false }
        didFailTransfer = true
        return true
    }
}
