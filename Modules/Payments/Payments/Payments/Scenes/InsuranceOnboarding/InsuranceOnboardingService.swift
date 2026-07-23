import Core
import Foundation

protocol InsuranceOnboardingServicing {
    func loadBenefits() async throws -> [Benefits]
}

final class InsuranceOnboardingService: InsuranceOnboardingServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadBenefits() async throws -> [Benefits] {
        let payloads: [InsuranceOnboardingBenefitPayload] = try await coreService.execute(
            InsuranceOnboardingEndpoint.benefits
        )
        return payloads.map(\.model)
    }
}

private enum InsuranceOnboardingEndpoint {
    case benefits
}

extension InsuranceOnboardingEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/insurance/benefits"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .benefits:
            return Self.encodeOrEmpty(InsuranceOnboardingBenefitPayload.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct InsuranceOnboardingBenefitPayload: Codable {
    let image: String
    let text: String

    static let mock: [InsuranceOnboardingBenefitPayload] = [
        .init(image: "checkmark.circle.fill", text: Strings.InsuranceOnboarding.benefitOne),
        .init(image: "checkmark.circle.fill", text: Strings.InsuranceOnboarding.benefitTwo),
        .init(image: "checkmark.circle.fill", text: Strings.InsuranceOnboarding.benefitThree),
        .init(image: "checkmark.circle.fill", text: Strings.InsuranceOnboarding.benefitFour)
    ]

    var model: Benefits {
        Benefits(image: image, text: text)
    }
}
