import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

protocol HomeAppServicing {
    func loadDashboard() async throws -> HomeAppDashboard
}

struct HomeAppDashboard: Codable, Hashable {
    struct User: Codable, Hashable {
        let firstName: String
        let lastName: String
    }

    struct Balance: Codable, Hashable {
        let currency: String
        let amount: Double
        let masked: Bool
    }

    struct RecentRecipient: Codable, Hashable, Identifiable {
        let id: String
        let name: String
        let pixKey: String
        let avatar: String
    }

    struct QuickAction: Codable, Hashable, Identifiable {
        enum Route: String, Codable, Hashable {
            case sendMoney
            case requestMoney
            case payBills
            case topUp
        }

        let id: String
        let title: String
        let subtitle: String
        let icon: String
        let route: Route
    }

    struct SpendingThisMonth: Codable, Hashable {
        struct Category: Codable, Hashable, Identifiable {
            let id: String
            let title: String
            let amount: Double
            let percentage: String
            let icon: String
            let colorToken: String
        }

        struct SeriesPoint: Codable, Hashable, Identifiable {
            let day: Int
            let amount: Double

            var id: Int { day }
        }

        let title: String
        let total: Double
        let changePercent: Double
        let comparisonLabel: String
        let categories: [Category]
        let series: [SeriesPoint]
    }

    struct Notifications: Codable, Hashable {
        let unreadCount: Int
    }

    let user: User
    let balance: Balance
    let cards: [Card]
    let recentRecipients: [RecentRecipient]
    let quickActions: [QuickAction]
    let spendingThisMonth: SpendingThisMonth
    let notifications: Notifications
}

final class HomeAppService: HomeAppServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadDashboard() async throws -> HomeAppDashboard {
        try await coreService.execute(HomeAppEndpoint.dashboard)
    }
}

private enum HomeAppEndpoint {
    case dashboard
}

extension HomeAppEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/home/dashboard"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .dashboard:
            return Self.encodeOrEmpty(HomeAppDashboard.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

extension HomeAppDashboard {
    static let mock = HomeAppDashboard(
        user: .init(
            firstName: "Blake",
            lastName: "Brown"
        ),
        balance: .init(
            currency: "USD",
            amount: 13_553.00,
            masked: false
        ),
        cards: CardsMock.creditCardMocks,
        recentRecipients: [
            .init(id: "ben_1", name: "Melissa", pixKey: "contact@melissamccarthy.com", avatar: "melissa"),
            .init(id: "ben_2", name: "Ed Sheeran", pixKey: "afirelove", avatar: "ed"),
            .init(id: "ben_3", name: "Adele", pixKey: "rollinginthedeep", avatar: "Adele"),
            .init(id: "ben_4", name: "Troy Bolton", pixKey: "scream", avatar: "Troy")
        ],
        quickActions: [
            .init(id: "transfer", title: Strings.QuickActions.sendTitle, subtitle: Strings.QuickActions.transferSubtitle, icon: "paperplane.fill", route: .sendMoney),
            .init(id: "request", title: Strings.QuickActions.requestTitle, subtitle: Strings.QuickActions.requestSubtitle, icon: "arrow.down", route: .requestMoney),
            .init(id: "pay", title: Strings.QuickActions.payTitle, subtitle: "Pay bills", icon: "creditcard.fill", route: .payBills),
            .init(id: "top_up", title: Strings.QuickActions.topUpTitle, subtitle: "Add funds", icon: "plus", route: .topUp)
        ],
        spendingThisMonth: .init(
            title: Strings.SpendingChart.title,
            total: 2_428.00,
            changePercent: 8.3,
            comparisonLabel: Strings.SpendingChart.comparison,
            categories: [
                .init(id: "shopping", title: Strings.SpendingChart.shopping, amount: 980.50, percentage: "40%", icon: "bag.fill", colorToken: "brandPrimaryColor"),
                .init(id: "bills", title: Strings.SpendingChart.bills, amount: 610.00, percentage: "25%", icon: "doc.text.fill", colorToken: "cyan"),
                .init(id: "transport", title: Strings.SpendingChart.transport, amount: 420.00, percentage: "17%", icon: "car.fill", colorToken: "success"),
                .init(id: "food_and_drinks", title: Strings.SpendingChart.foodAndDrinks, amount: 417.50, percentage: "18%", icon: "fork.knife", colorToken: "orange")
            ],
            series: [
                .init(day: 1, amount: 220.0),
                .init(day: 2, amount: 280.0),
                .init(day: 3, amount: 240.0),
                .init(day: 4, amount: 210.0),
                .init(day: 5, amount: 200.0),
                .init(day: 6, amount: 390.0),
                .init(day: 7, amount: 330.0),
                .init(day: 8, amount: 270.0),
                .init(day: 9, amount: 285.0),
                .init(day: 10, amount: 215.0),
                .init(day: 11, amount: 350.0),
                .init(day: 12, amount: 410.0),
                .init(day: 13, amount: 250.0),
                .init(day: 14, amount: 180.0),
                .init(day: 15, amount: 240.0),
                .init(day: 16, amount: 340.0),
                .init(day: 17, amount: 360.0),
                .init(day: 18, amount: 420.5),
                .init(day: 19, amount: 300.0),
                .init(day: 20, amount: 330.0),
                .init(day: 21, amount: 290.0),
                .init(day: 22, amount: 390.0),
                .init(day: 23, amount: 520.0),
                .init(day: 24, amount: 210.0),
                .init(day: 25, amount: 200.0),
                .init(day: 26, amount: 315.0),
                .init(day: 27, amount: 370.0),
                .init(day: 28, amount: 350.0),
                .init(day: 29, amount: 260.0),
                .init(day: 30, amount: 230.0),
                .init(day: 31, amount: 190.0),
                .init(day: 32, amount: 315.0)
            ]
        ),
        notifications: .init(unreadCount: 3)
    )
}
