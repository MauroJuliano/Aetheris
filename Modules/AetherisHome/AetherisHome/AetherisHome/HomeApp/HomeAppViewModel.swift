import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class HomeAppViewModel: ObservableObject {
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
}
