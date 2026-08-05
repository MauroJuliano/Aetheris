import AetherisAuthenticationInterface
import Core
import Foundation

protocol IdentityValidationServicing {
    func validate(pin: String) async throws -> IdentityAuthorization
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

final class IdentityValidationService: IdentityValidationServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func validate(pin: String) async throws -> IdentityAuthorization {
        let response: IdentityValidationResponse = try await coreService.execute(
            IdentityValidationEndpoint.validate(.init(pin: pin))
        )
        guard response.isAuthorized, let authorization = response.authorization else {
            throw IdentityValidationError.rejected
        }
        return authorization
    }
}

private enum IdentityValidationEndpoint {
    case validate(IdentityValidationRequest)
}

extension IdentityValidationEndpoint: Endpoint {
    var path: String { "/security/identity/validate" }
    var method: HTTPMethod { .post }
    var body: Encodable? {
        guard case let .validate(request) = self else { return nil }
        return request
    }

    var mockResponseData: Data {
        guard case let .validate(request) = self else { return Data() }
        let authorization = request.pin == "1234"
            ? IdentityAuthorization(
                token: "demo-transfer-authorization",
                expiresAt: "2026-08-04T12:00:00Z"
            )
            : nil
        let response = IdentityValidationResponse(
            isAuthorized: authorization != nil,
            authorization: authorization
        )
        return (try? JSONEncoder().encode(response)) ?? Data()
    }
}
