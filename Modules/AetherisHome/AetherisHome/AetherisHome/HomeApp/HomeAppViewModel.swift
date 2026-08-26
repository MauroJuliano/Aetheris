import AetherisDesignSystem
import Foundation
import SwiftUI

struct SpendingAnalyticsCardModel: Equatable {
    let title: String
    let totalTitle: String
    let changeTitle: String
    let comparisonTitle: String
    let categories: [AnalyticsCategorySummaryItemModel]
}

@MainActor
final class HomeAppViewModel: ObservableObject {
    enum QuickActionDestination {
        case transfer
        case request
        case more
    }

    private static let sendQuickActionId = "send"
    private static let requestQuickActionId = "request"
    private static let moreQuickActionId = "more_services"

    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published var cards: [Card] = []
    @Published var recentRecipients: [Beneficiary] = []
    @Published var spendingThisMonth: HomeAppDashboard.SpendingThisMonth?

    @Published private(set) var userFirstName: String = Strings.HomeApp.welcomeName
    @Published private(set) var balanceText: String = "$ 0.00"
    @Published private(set) var isBalanceVisible = true
    @Published private(set) var unreadCount = 0
    var hasUnreadNotifications: Bool { unreadCount > 0 }
    var recipientItems: [RecipientItem] {
        recentRecipients.map { RecipientItem(id: $0.id, name: $0.name, imageName: $0.image) }
    }

    func recipient(for id: UUID) -> Beneficiary? {
        recentRecipients.first { $0.id == id }
    }
    func selectedCardId(at index: Int) -> UUID? {
        guard !cards.isEmpty else { return nil }

        let safeIndex = min(max(index, 0), cards.count - 1)
        return cards[safeIndex].id
    }

    var quickActionItems: [QuickActionItem] {
        [
            .init(
                id: Self.sendQuickActionId,
                title: Strings.QuickActions.sendTitle,
                subtitle: Strings.QuickActions.transferSubtitle,
                icon: "paperplane.fill"
            ),
            .init(
                id: Self.requestQuickActionId,
                title: Strings.QuickActions.requestTitle,
                subtitle: Strings.QuickActions.requestSubtitle,
                icon: "arrow.down"
            ),
            .init(
                id: Self.moreQuickActionId,
                title: Strings.QuickActions.moreTitle,
                subtitle: Strings.QuickActions.moreSubtitle,
                icon: "ellipsis"
            )
        ]
    }

    func quickActionDestination(for itemID: String) -> QuickActionDestination {
        switch itemID {
        case Self.sendQuickActionId:
            return .transfer
        case Self.requestQuickActionId:
            return .request
        default:
            return .more
        }
    }

    var spendingAnalyticsCardModel: SpendingAnalyticsCardModel {
        let spending = spendingThisMonth ?? HomeAppDashboard.mock.spendingThisMonth

        return SpendingAnalyticsCardModel(
            title: Strings.SpendingChart.title,
            totalTitle: currencyText(spending.total),
            changeTitle: Self.changeText(spending.changePercent),
            comparisonTitle: Strings.SpendingChart.comparison,
            categories: spending.categories.map {
                AnalyticsCategorySummaryItemModel(
                    id: $0.id,
                    title: Self.categoryTitle(for: $0.id),
                    amount: amountText($0.amount),
                    percentage: Self.percentageText(amount: $0.amount, total: spending.total),
                    icon: Self.categoryIcon(for: $0.id),
                    iconColor: Self.categoryColor(for: $0.id)
                )
            }
        )
    }

    private let service: any HomeAppServicing
    private let locale: Locale
    private var latestLoadID = UUID()
    private var hasLoaded = false

    init(service: any HomeAppServicing, locale: Locale = .current) {
        self.service = service
        self.locale = locale
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await load()
    }

    func load() async {
        let loadID = UUID()
        latestLoadID = loadID
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            let dashboard = try await service.loadDashboard()
            guard latestLoadID == loadID else { return }

            userFirstName = dashboard.user.firstName
            balanceText = Self.balanceText(
                currency: dashboard.balance.currency,
                amount: dashboard.balance.amount,
                locale: locale
            )
            isBalanceVisible = !dashboard.balance.masked
            cards = dashboard.cards
            recentRecipients = dashboard.recentRecipients.map(Self.mapRecipient(_:))
            spendingThisMonth = dashboard.spendingThisMonth
            unreadCount = dashboard.notifications.unreadCount
            isEmpty = cards.isEmpty
        } catch {
            guard latestLoadID == loadID else { return }
            errorMessage = Strings.HomeApp.cardsLoadFailed
        }

        isLoading = false
    }

    private static func mapRecipient(_ recipient: HomeAppDashboard.RecentRecipient) -> Beneficiary {
        Beneficiary(
            id: UUID(uuidString: recipient.id) ?? UUID(),
            name: recipient.name,
            pixKey: recipient.pixKey,
            image: recipient.avatar,
            hasDivider: true
        )
    }

    private static func balanceText(currency: String, amount: Double, locale: Locale) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formattedAmount = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        let currencySymbol = currency == "USD" ? "$" : currency

        return "\(currencySymbol) \(formattedAmount)"
    }

    private func currencyText(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formatted = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        return "$ \(formatted)"
    }

    private static func changeText(_ value: Double) -> String {
        String(format: "%+.0f%%", value)
    }

    private static func categoryTitle(for id: String) -> String {
        switch id {
        case "shopping": Strings.SpendingChart.shopping
        case "bills": Strings.SpendingChart.bills
        case "transport": Strings.SpendingChart.transport
        case "food_and_drinks": Strings.SpendingChart.foodAndDrinks
        default: id
        }
    }

    private static func categoryIcon(for id: String) -> String {
        switch id {
        case "shopping": "bag.fill"
        case "bills": "doc.text.fill"
        case "transport": "car.fill"
        case "food_and_drinks": "fork.knife"
        default: "circle.fill"
        }
    }

    private static func categoryColor(for id: String) -> Color {
        switch id {
        case "shopping": .brandPrimaryColor
        case "bills": .cyan
        case "transport": .success
        case "food_and_drinks": .orange
        default: .brandPrimaryColor
        }
    }

    private static func percentageText(amount: Double, total: Double) -> String {
        guard total > 0 else { return "0%" }
        return "\(Int((amount / total * 100).rounded()))%"
    }

    private func amountText(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formatted = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        return "$ \(formatted)"
    }
}
