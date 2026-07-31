import Foundation

struct AllServicesItem: Identifiable, Codable {
    enum Theme: String, Codable {
        case primary
        case success
        case info
        case warning
    }

    var id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let theme: Theme
}

enum AllServicesFixtures {
    static let items: [AllServicesItem] = [
        .init(
            title: Strings.AllServices.transferMoney,
            subtitle: Strings.SendMoney.title,
            icon: "arrow.right.arrow.left",
            theme: .primary
        ),
        .init(
            title: Strings.AllServices.manageBeneficiaries,
            subtitle: Strings.Recipients.title,
            icon: "person.2.fill",
            theme: .info
        ),
        .init(
            title: Strings.AllServices.cardCenter,
            subtitle: Strings.CardHome.title,
            icon: "creditcard.fill",
            theme: .warning
        ),
        .init(
            title: Strings.AllServices.notifications,
            subtitle: Strings.NotificationsCentre.title,
            icon: "bell.fill",
            theme: .primary
        ),
        .init(
            title: Strings.AllServices.insurance,
            subtitle: Strings.InsuranceOnboarding.moreOptions,
            icon: "shield.checkered",
            theme: .success
        ),
        .init(
            title: Strings.AllServices.reports,
            subtitle: Strings.SpendingChart.viewReport,
            icon: "chart.bar.fill",
            theme: .info
        )
    ]
}
