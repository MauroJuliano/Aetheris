import Core
import Foundation

protocol CardInsuranceServicing {
    func loadBullets() async throws -> [CardInsuranceBullet]
}

final class CardInsuranceService: CardInsuranceServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadBullets() async throws -> [CardInsuranceBullet] {
        let payloads: [CardInsuranceBulletPayload] = try await coreService.execute(
            CardInsuranceEndpoint.bullets
        )
        return payloads.map(\.model)
    }
}

private enum CardInsuranceEndpoint {
    case bullets
}

extension CardInsuranceEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/card-insurance/bullets"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .bullets:
            return Self.encodeOrEmpty(CardInsuranceBulletPayload.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct CardInsuranceBulletPayload: Codable {
    let text: String

    static let mock: [CardInsuranceBulletPayload] = [
        .init(text: Strings.CardInsurance.bulletOne),
        .init(text: Strings.CardInsurance.bulletTwo),
        .init(text: Strings.CardInsurance.bulletThree),
        .init(text: Strings.CardInsurance.bulletFour)
    ]

    var model: CardInsuranceBullet {
        CardInsuranceBullet(text: text)
    }
}
