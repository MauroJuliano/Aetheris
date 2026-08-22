import AetherisDesignSystem
import Core
import Foundation

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
