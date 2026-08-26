import AetherisDesignSystem
import Foundation

extension HomeAppDashboard {
    static let mock = HomeAppDashboard(
        user: .init(firstName: "Blake", lastName: "Brown"),
        balance: .init(currency: "USD", amount: 13_553.00, masked: false),
        cards: CardsMock.creditCardMocks,
        recentRecipients: BeneficiaryFixtures.defaults.map {
            .init(id: $0.id.uuidString, name: $0.name, pixKey: $0.pixKey, avatar: $0.image)
        },
        spendingThisMonth: .init(
            total: 2_428.00,
            changePercent: 8.3,
            categories: [
                .init(id: "shopping", amount: 980.50),
                .init(id: "bills", amount: 610.00),
                .init(id: "transport", amount: 420.00),
                .init(id: "food_and_drinks", amount: 417.50)
            ],
            series: [
                220, 280, 240, 210, 200, 390, 330, 270,
                285, 215, 350, 410, 250, 180, 240, 340,
                360, 420.5, 300, 330, 290, 390, 520, 210,
                200, 315, 370, 350, 260, 230, 190, 315
            ].enumerated().map { index, amount in
                .init(day: index + 1, amount: amount)
            }
        ),
        notifications: .init(unreadCount: 3)
    )
}
