import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

protocol HomeAppServicing {
    func loadCards() async throws -> [Card]
}

final class HomeAppService: HomeAppServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadCards() async throws -> [Card] {
        try await coreService.execute(HomeAppEndpoint.cards)
    }
}

private enum HomeAppEndpoint {
    case cards
}

extension HomeAppEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/home/cards"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .cards:
            return Self.encodeOrEmpty(CardsMock.creditCardMocks)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
