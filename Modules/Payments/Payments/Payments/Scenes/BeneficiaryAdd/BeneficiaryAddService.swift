import Core
import Foundation

protocol BeneficiaryAddServicing {
    func createBeneficiary(
        name: String,
        pixKey: String,
        image: String
    ) async throws -> Beneficiary
}

final class BeneficiaryAddService: BeneficiaryAddServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func createBeneficiary(
        name: String,
        pixKey: String,
        image: String
    ) async throws -> Beneficiary {
        let response: BeneficiaryAddResponse = try await coreService.execute(
            BeneficiaryAddEndpoint.create(
                request: .init(
                    name: name,
                    pixKey: pixKey,
                    image: image
                )
            )
        )

        return response.model
    }
}

private enum BeneficiaryAddEndpoint {
    case create(request: BeneficiaryAddRequest)
}

extension BeneficiaryAddEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/beneficiaries"
    }

    var method: HTTPMethod {
        .post
    }

    var body: Encodable? {
        switch self {
        case let .create(request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case let .create(request):
            return Self.encodeOrEmpty(
                BeneficiaryAddResponse(
                    name: request.name,
                    pixKey: request.pixKey,
                    image: request.image,
                    hasDivider: true
                )
            )
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct BeneficiaryAddRequest: Codable {
    let name: String
    let pixKey: String
    let image: String
}

private struct BeneficiaryAddResponse: Codable {
    let name: String
    let pixKey: String
    let image: String
    let hasDivider: Bool

    var model: Beneficiary {
        Beneficiary(
            name: name,
            pixKey: pixKey,
            image: image,
            hasDivider: hasDivider
        )
    }
}
