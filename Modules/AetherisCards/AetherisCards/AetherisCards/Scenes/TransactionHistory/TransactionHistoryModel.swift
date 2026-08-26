import Foundation
import SwiftUI

@MainActor
final class TransactionHistoryViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var sections: [Section] = []

    private let service: any TransactionHistoryServicing

    init(service: any TransactionHistoryServicing) {
        self.service = service
    }

    struct Section: Identifiable {
        let id: String
        let title: String
        let titleWidth: CGFloat
        let items: [FinancialSummaryModel]
    }

    var displayedSections: [Section] {
        guard isLoading else { return sections }
        return [
            .init(id: "loading-1", title: "", titleWidth: 56, items: [.placeholder, .placeholder]),
            .init(id: "loading-2", title: "", titleWidth: 88, items: [.placeholder]),
            .init(id: "loading-3", title: "", titleWidth: 78, items: [.placeholder, .placeholder])
        ]
    }
    
    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            let transactions = try await service.loadTransactions()
            buildSections(from: transactions)
            isEmpty = transactions.isEmpty
        } catch {
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.TransactionHistory.loadFailed
            )
        }

        isLoading = false
    }

    private func buildSections(from transactions: [FinancialSummaryModel]) {
        let order = [
            Strings.Notifications.sectionToday,
            Strings.Notifications.sectionYesterday,
            Strings.Notifications.sectionLastWeek,
            Strings.Notifications.sectionLastMonth,
            Strings.Notifications.sectionOthers
        ]
        let grouped = Dictionary(grouping: transactions) { $0.section }
        let sorted = grouped.keys.sorted {
            (order.firstIndex(of: $0) ?? Int.max) <
            (order.firstIndex(of: $1) ?? Int.max)
        }
        sections = sorted.map {
            Section(id: $0,
                    title: $0,
                    titleWidth: 0,
                    items: grouped[$0] ?? [])
        }
    }
}
