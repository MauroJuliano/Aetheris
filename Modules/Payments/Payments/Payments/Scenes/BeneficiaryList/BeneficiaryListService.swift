import Core
import Foundation

protocol BeneficiaryListServicing {
    func loadBeneficiaryList() async throws -> BeneficiaryListResponse
}

struct BeneficiaryListResponse: Codable, Hashable {
    let beneficiaries: [Beneficiary]
}

final class BeneficiaryListService: BeneficiaryListServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadBeneficiaryList() async throws -> BeneficiaryListResponse {
        try await coreService.execute(BeneficiaryListEndpoint.list)
    }
}

private enum BeneficiaryListEndpoint {
    case list
}

extension BeneficiaryListEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/beneficiaries/recent"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .list:
            return Self.encodeOrEmpty(BeneficiaryListResponse.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

extension BeneficiaryListResponse {
    static let mock = BeneficiaryListResponse(
        beneficiaries: Beneficiary.mock
    )
}
