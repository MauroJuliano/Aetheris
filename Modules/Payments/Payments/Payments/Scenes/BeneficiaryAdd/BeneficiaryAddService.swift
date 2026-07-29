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
        let beneficiaries: [Beneficiary] = try await coreService.execute(
            BeneficiaryAddEndpoint.search(
                identifier: identifier
            )
        )

        guard let beneficiary = beneficiaries.first(where: {
            Self.matches(identifier: identifier, beneficiary: $0)
        }) else {
            throw BeneficiaryAddError.notFound
        }

        return beneficiary
    }

    private static func matches(identifier: String, beneficiary: Beneficiary) -> Bool {
        let normalized = identifier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let name = beneficiary.name.lowercased()
        let pixKey = beneficiary.pixKey.lowercased()

        return normalized == name
            || normalized == pixKey
            || name.contains(normalized)
            || pixKey.contains(normalized)
    }
}

private enum BeneficiaryAddEndpoint {
    case search(identifier: String)
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
        case let .search(identifier):
            return identifier
        }
    }

    var mockResponseData: Data {
        switch self {
        case .search:
            return Self.encodeOrEmpty(Beneficiary.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private enum BeneficiaryAddError: Error {
    case notFound
}
