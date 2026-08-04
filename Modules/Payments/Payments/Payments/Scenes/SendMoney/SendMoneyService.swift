import Core
import Foundation

protocol SendMoneyServicing {
    func loadSession() async throws -> SendMoneySession
    func validate(pin: String) async throws -> IdentityAuthorization
    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse
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

    let wallet: Wallet
    let account: Account
}

private struct IdentityValidationRequest: Encodable {
    let pin: String
}

private struct IdentityValidationResponse: Codable {
    let isAuthorized: Bool
    let authorization: IdentityAuthorization?
}

enum IdentityValidationError: Error, Equatable {
    case rejected
}

final class SendMoneyService: SendMoneyServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadSession() async throws -> SendMoneySession {
        try await coreService.execute(SendMoneyEndpoint.session)
    }

    func validate(pin: String) async throws -> IdentityAuthorization {
        let response: IdentityValidationResponse = try await coreService.execute(
            SendMoneyEndpoint.validateIdentity(.init(pin: pin))
        )
        guard response.isAuthorized, let authorization = response.authorization else {
            throw IdentityValidationError.rejected
        }
        return authorization
    }

    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse {
        let request = TransferRequest(
            amount: submission.draft.amount,
            currency: submission.draft.currency,
            beneficiaryIdentifier: submission.draft.beneficiaryIdentifier,
            authorizationToken: submission.authorization.token
        )
        return try await coreService.execute(
            SendMoneyEndpoint.submitTransfer(
                request: request,
                draft: submission.draft,
                idempotencyKey: submission.idempotencyKey
            )
        )
    }
}

private enum SendMoneyEndpoint {
    case session
    case validateIdentity(IdentityValidationRequest)
    case submitTransfer(
        request: TransferRequest,
        draft: TransferDraft,
        idempotencyKey: String
    )
}

extension SendMoneyEndpoint: Endpoint {
    var path: String {
        switch self {
        case .session:
            "/payments/send-money/session"
        case .validateIdentity:
            "/security/identity/validate"
        case .submitTransfer:
            "/payments/transfers"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .session: .get
        case .validateIdentity, .submitTransfer: .post
        }
    }

    var headers: [String: String] {
        guard case let .submitTransfer(_, _, idempotencyKey) = self else { return [:] }
        return ["Idempotency-Key": idempotencyKey]
    }

    var body: Encodable? {
        switch self {
        case .session:
            nil
        case let .validateIdentity(request):
            request
        case let .submitTransfer(request, _, _):
            request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .session:
            return Self.encodeOrEmpty(SendMoneySession.mock)
        case let .validateIdentity(request):
            let authorization = request.pin == "1234"
                ? IdentityAuthorization(token: "demo-transfer-authorization", expiresAt: "2026-08-04T12:00:00Z")
                : nil
            return Self.encodeOrEmpty(
                IdentityValidationResponse(isAuthorized: authorization != nil, authorization: authorization)
            )
        case let .submitTransfer(_, draft, idempotencyKey):
            return Self.encodeOrEmpty(
                TransferReceiptResponse(
                    transactionId: idempotencyKey,
                    referenceId: "TRX-\(idempotencyKey.prefix(8).uppercased())",
                    status: "completed",
                    amount: NSDecimalNumber(decimal: draft.amount).doubleValue,
                    currency: draft.currency,
                    recipientName: draft.beneficiaryName,
                    recipientIdentifier: draft.beneficiaryIdentifier,
                    accountName: draft.accountName,
                    accountLastDigits: draft.accountLastDigits,
                    completedAt: "August 4, 2026 at 12:00 PM"
                )
            )
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
        )
    )
}
