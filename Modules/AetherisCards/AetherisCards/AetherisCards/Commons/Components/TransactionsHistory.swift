import SwiftUI
import AetherisDesignSystem

struct TransactionsHistory: View {
    private var rows: [ListCell.Model] {
        CardActivityPreviewData.transactions(for: CardsPreviewData.cardId)
            .map {
                .init(
                    title: $0.title,
                    subtitle: $0.description,
                    value: $0.value,
                    icon: Self.icon(for: $0.tag)
                )
            }
    }
    
    var body: some View {
        VStack {
            MinimalDropdown(title: Strings.TransactionHistory.title)
                .padding()

            ForEach(rows.indices, id: \.self) { index in
                ListCell(model: rows[index])
            }
        }
    }

    private static func icon(for type: TransactionType) -> String {
        switch type {
        case .transfer:
            return "arrow.up.right"
        case .income:
            return "arrow.down"
        case .expense:
            return "bag"
        }
    }
}

#Preview {
    TransactionsHistory()
        .padding()
        .appScreenBackground()
}
