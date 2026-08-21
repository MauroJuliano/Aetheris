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
    @Published var quickActions: [HomeAppDashboard.QuickAction] = []
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
        let actions = quickActions.isEmpty ? HomeAppDashboard.mock.quickActions : quickActions
        let sendAction = actions.first { $0.route == .sendMoney }
        let requestAction = actions.first { $0.route == .requestMoney }

        return [
            .init(
                id: Self.sendQuickActionId,
                title: sendAction?.title ?? Strings.QuickActions.sendTitle,
                subtitle: sendAction?.subtitle ?? Strings.QuickActions.transferSubtitle,
                icon: sendAction?.icon ?? "paperplane.fill"
            ),
            .init(
                id: Self.requestQuickActionId,
                title: requestAction?.title ?? Strings.QuickActions.requestTitle,
                subtitle: requestAction?.subtitle ?? Strings.QuickActions.requestSubtitle,
                icon: requestAction?.icon ?? "arrow.down"
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
            title: spending.title,
            totalTitle: Self.currencyText(spending.total),
            changeTitle: Self.changeText(spending.changePercent),
            comparisonTitle: spending.comparisonLabel,
            categories: spending.categories.map {
                AnalyticsCategorySummaryItemModel(
                    id: $0.id,
                    title: $0.title,
                    amount: Self.amountText($0.amount),
                    percentage: $0.percentage,
                    icon: $0.icon,
                    iconColor: Self.color(from: $0.colorToken)
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
            quickActions = dashboard.quickActions
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

    private static func currencyText(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formatted = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        return "$ \(formatted)"
    }

    private static func changeText(_ value: Double) -> String {
        String(format: "%+.0f%%", value)
    }

    private static func color(from token: String) -> Color {
        switch token {
        case "brandPrimaryColor":
            return .brandPrimaryColor
        case "cyan":
            return .cyan
        case "success":
            return .success
        case "orange":
            return .orange
        default:
            return .brandPrimaryColor
        }
    }

    private static func amountText(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formatted = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        return "$ \(formatted)"
    }
}
