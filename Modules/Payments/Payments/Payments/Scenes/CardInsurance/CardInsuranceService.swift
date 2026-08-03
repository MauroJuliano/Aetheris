import Core
import Foundation

protocol CardInsuranceServicing {
    func loadBullets() async throws -> CardInsuranceResponse
}

final class CardInsuranceService: CardInsuranceServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadBullets() async throws -> CardInsuranceResponse {
        try await coreService.execute(CardInsuranceEndpoint.bullets)
    }
}

private enum CardInsuranceEndpoint {
    case bullets
}

extension CardInsuranceEndpoint: Endpoint {
    var path: String {
        "/payments/card-insurance/bullets"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .bullets:
            return Self.encodeOrEmpty(CardInsuranceResponse.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private extension CardInsuranceResponse {
    static let mock = CardInsuranceResponse(bullets: [
        .init(text: Strings.CardInsurance.bulletOne),
        .init(text: Strings.CardInsurance.bulletTwo),
        .init(text: Strings.CardInsurance.bulletThree),
        .init(text: Strings.CardInsurance.bulletFour)
    ])
}
