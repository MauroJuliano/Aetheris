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
        let items: [FinancialSummaryModel]
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
            errorMessage = "We could not load your transaction history."
        }

        isLoading = false
    }

    private func buildSections(from transactions: [FinancialSummaryModel]) {
        let order = ["Today", "Yesterday", "Last Week", "Last Month", "Others"]
        let grouped = Dictionary(grouping: transactions) { $0.section }
        let sorted = grouped.keys.sorted {
            (order.firstIndex(of: $0) ?? Int.max) <
            (order.firstIndex(of: $1) ?? Int.max)
        }
        sections = sorted.map {
            Section(id: $0,
                    title: $0,
                    items: grouped[$0] ?? [])
        }
    }
}
