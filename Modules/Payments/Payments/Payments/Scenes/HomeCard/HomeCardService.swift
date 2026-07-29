import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

protocol HomeCardServicing {
    func loadDashboard() async throws -> HomeCardDashboard
}

struct HomeCardDashboard: Codable {
    let cards: [Card]
    let summaries: [FinancialSummaryModel]
    let quickActions: [CardOptions]
}

final class HomeCardService: HomeCardServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadDashboard() async throws -> HomeCardDashboard {
        try await coreService.execute(HomeCardEndpoint.dashboard)
    }
}

private enum HomeCardEndpoint {
    case dashboard
}

extension HomeCardEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/home-card/dashboard"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .dashboard:
            return Self.encodeOrEmpty(HomeCardDashboard.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private extension HomeCardDashboard {
    static let mock = HomeCardDashboard(
        cards: CardsMock.creditCardMocks,
        summaries: FinancialSummaryModel.mock,
        quickActions: CardOptions.mock
    )
}
