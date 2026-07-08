import SwiftUI
import AetherisDesignSystem

struct TransactionsHistory: View {
    private let rows: [ListCell.Model] = [
        .init(title: "Swarovski", subtitle: "Payment", value: "-46.99", icon: "bag"),
        .init(title: "Netflix", subtitle: "Subscription", value: "-19.99", icon: "play.rectangle"),
        .init(title: "Melissa", subtitle: "Transfer received", value: "+250.00", icon: "person.fill"),
        .init(title: "Apple", subtitle: "Purchase", value: "-14.90", icon: "applelogo"),
        .init(title: "Salary", subtitle: "Deposit", value: "+2,850.00", icon: "building.columns")
    ]
    
    var body: some View {
        VStack {
            MinimalDropdown(title: "Transactions History")
                .padding()

            ForEach(rows.indices, id: \.self) { index in
                ListCell(model: rows[index])
            }
        }
    }
}

#Preview {
    TransactionsHistory()
}
