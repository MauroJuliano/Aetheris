import Core
import Foundation

protocol BeneficiaryAddServicing {
    func findBeneficiary(
        identifier: String
    ) async throws -> Beneficiary
}

final class BeneficiaryAddService: BeneficiaryAddServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func findBeneficiary(
        identifier: String
    ) async throws -> Beneficiary {
        let response: BeneficiaryAddResponse = try await coreService.execute(
            BeneficiaryAddEndpoint.search(
                request: .init(
                    identifier: identifier
                )
            )
        )

        return response.model
    }
}

private enum BeneficiaryAddEndpoint {
    case search(request: BeneficiaryAddRequest)
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
        case let .search(request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case let .search(request):
            guard let selected = Self.mockBeneficiary(for: request.identifier) else {
                return Data()
            }

            return Self.encodeOrEmpty(
                BeneficiaryAddResponse(
                    name: selected.name,
                    pixKey: request.identifier,
                    image: selected.image,
                    hasDivider: true
                )
            )
        }
    }

    private static func mockBeneficiary(for identifier: String) -> Beneficiary? {
        let normalized = identifier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        return Beneficiary.beneficiaries.first(where: {
            let name = $0.name.lowercased()
            let pixKey = $0.pixKey.lowercased()
            return normalized.contains(name) || normalized.contains(pixKey) || name.contains(normalized)
        })
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct BeneficiaryAddRequest: Codable {
    let identifier: String
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
