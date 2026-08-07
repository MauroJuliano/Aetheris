import SwiftUI
import AetherisDesignSystem

struct TransactionsHistory: View {
    private let rows: [ListCell.Model] = [
        .init(title: Strings.TransactionsHistory.swarovski, subtitle: Strings.TransactionsHistory.payment, value: "-46.99", icon: "bag"),
        .init(title: Strings.TransactionsHistory.netflix, subtitle: Strings.TransactionsHistory.subscription, value: "-19.99", icon: "play.rectangle"),
        .init(title: Strings.TransactionsHistory.melissa, subtitle: Strings.TransactionsHistory.transferReceived, value: "+250.00", icon: "person.fill"),
        .init(title: Strings.TransactionsHistory.apple, subtitle: Strings.TransactionsHistory.purchase, value: "-14.90", icon: "applelogo"),
        .init(title: Strings.TransactionsHistory.salary, subtitle: Strings.TransactionsHistory.deposit, value: "+2,850.00", icon: "building.columns")
    ]
    
    var body: some View {
        VStack {
            MinimalDropdown(title: Strings.TransactionHistory.title)
                .padding()

            ForEach(rows.indices, id: \.self) { index in
                ListCell(model: rows[index])
            }
        }
    }
}

#Preview {
    TransactionsHistory()
        .padding()
        .appScreenBackground()
}
