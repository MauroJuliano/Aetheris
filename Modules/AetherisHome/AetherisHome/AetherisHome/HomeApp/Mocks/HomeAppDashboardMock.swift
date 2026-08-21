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
        quickActions: [
            .init(id: "transfer", title: Strings.QuickActions.sendTitle, subtitle: Strings.QuickActions.transferSubtitle, icon: "paperplane.fill", route: .sendMoney),
            .init(id: "request", title: Strings.QuickActions.requestTitle, subtitle: Strings.QuickActions.requestSubtitle, icon: "arrow.down", route: .requestMoney),
            .init(id: "pay", title: Strings.QuickActions.payTitle, subtitle: Strings.QuickActions.paySubtitle, icon: "creditcard.fill", route: .payBills),
            .init(id: "top_up", title: Strings.QuickActions.topUpTitle, subtitle: Strings.QuickActions.topUpSubtitle, icon: "plus", route: .topUp)
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
