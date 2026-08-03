import Core
import Foundation

protocol SendMoneyServicing {
    func loadSession() async throws -> SendMoneySession
}

struct SendMoneySession: Codable, Hashable {
    struct Account: Codable, Hashable {
        let name: String
        let lastDigits: String
    }

    struct Wallet: Codable, Hashable {
        let currency: String
        let balance: Double
        let available: Double
    }

    struct Limits: Codable, Hashable {
        let currency: String
        let dailyLimit: Double
        let remainingDailyLimit: Double
        let singleTransferLimit: Double
    }

    struct Fee: Codable, Hashable {
        let label: String
        let amount: Double
        let currency: String
    }

    let wallet: Wallet
    let account: Account
    let limits: Limits
    let fees: [Fee]
    let securityMessage: String
    let processingMessage: String
    let suggestedAmount: Double
}

final class SendMoneyService: SendMoneyServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadSession() async throws -> SendMoneySession {
        try await coreService.execute(SendMoneyEndpoint.session)
    }
}

private enum SendMoneyEndpoint {
    case session
}

extension SendMoneyEndpoint: Endpoint {
    var path: String {
        "/payments/send-money/session"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .session:
            return Self.encodeOrEmpty(SendMoneySession.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

extension SendMoneySession {
    static let mock = SendMoneySession(
        wallet: .init(
            currency: "USD",
            balance: 1_000.00,
            available: 1_000.00
        ),
        account: .init(
            name: "Main Account",
            lastDigits: "1234"
        ),
        limits: .init(
            currency: "USD",
            dailyLimit: 2_500.00,
            remainingDailyLimit: 1_810.00,
            singleTransferLimit: 1_000.00
        ),
        fees: [
            .init(label: "Instant transfer", amount: 0.00, currency: "USD")
        ],
        securityMessage: "Transfer protected by biometrics and device verification.",
        processingMessage: "Your transfer is being processed.",
        suggestedAmount: 250.00
    )
}
