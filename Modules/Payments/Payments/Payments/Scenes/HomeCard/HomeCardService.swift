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
        summaries: [
            .init(
                cardId: CardMockIDs.standard,
                image: "melissa",
                title: Strings.FinancialSummary.transferSent,
                description: Strings.FinancialSummary.transferSentDescription,
                value: "-$ 250.00",
                tag: .transfer,
                date: Date()
            ),
            .init(
                cardId: CardMockIDs.standard,
                image: "ed",
                title: Strings.FinancialSummary.paymentReceived,
                description: Strings.FinancialSummary.paymentReceivedDescription,
                value: "$ 125.00",
                tag: .income,
                date: Date()
            ),
            .init(
                cardId: CardMockIDs.gold,
                image: "NetflixLogo",
                title: Strings.FinancialSummary.netflix,
                description: Strings.FinancialSummary.subscription,
                value: "-$ 20.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
            ),
            .init(
                cardId: CardMockIDs.infinite,
                image: "applelogo",
                title: Strings.FinancialSummary.appleBill,
                description: Strings.FinancialSummary.subscription,
                value: "-$ 9.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
            ),
            .init(
                cardId: CardMockIDs.infinite,
                image: "ifoodlogo",
                title: Strings.FinancialSummary.ifoodBar,
                description: Strings.FinancialSummary.restaurant,
                value: "-$ 30.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
            ),
            .init(
                cardId: CardMockIDs.gold,
                image: "Adele",
                title: Strings.FinancialSummary.transferSent,
                description: Strings.FinancialSummary.transferSentAdeleDescription,
                value: "-$ 70.00",
                tag: .transfer,
                date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date()
            )
        ]
    )
}
