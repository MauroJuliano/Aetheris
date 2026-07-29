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

    private let service: any HomeAppServicing

    init(service: any HomeAppServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            let dashboard = try await service.loadDashboard()

            userFirstName = dashboard.user.firstName
            balanceText = Self.balanceText(
                currency: dashboard.balance.currency,
                amount: dashboard.balance.amount
            )
            isBalanceVisible = !dashboard.balance.masked
            cards = dashboard.cards
            recentRecipients = dashboard.recentRecipients.map(Self.mapRecipient(_:))
            quickActions = dashboard.quickActions
            spendingThisMonth = dashboard.spendingThisMonth
            unreadCount = dashboard.notifications.unreadCount
            isEmpty = cards.isEmpty
        } catch {
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

    private static func balanceText(currency: String, amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = currency == "USD" ? "$" : currency

        let formattedAmount = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        return formattedAmount.replacingOccurrences(of: "$", with: "$ ")
    }
}
