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

    struct SpendingThisMonth: Codable, Hashable {
        struct Category: Codable, Hashable, Identifiable {
            let id: String
            let amount: Double
        }

        struct SeriesPoint: Codable, Hashable, Identifiable {
            let day: Int
            let amount: Double

            var id: Int { day }
        }

        let total: Double
        let changePercent: Double
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
