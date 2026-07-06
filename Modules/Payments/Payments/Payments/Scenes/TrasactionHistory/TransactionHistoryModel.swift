import SwiftUI

@MainActor
final class TransactionHistoryViewModel: ObservableObject {
    
    @Published private(set) var sections: [Section] = []
    
    struct Section: Identifiable {
        let id: String
        let title: String
        let items: [FinancialSummaryModel]
    }
    
    func load() async {
        let data = FinancialSummaryModel.mock
        buildSections(from: data)
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
