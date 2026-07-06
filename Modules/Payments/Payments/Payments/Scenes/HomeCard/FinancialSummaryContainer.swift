import AetherisDesignSystem
import SwiftUI

struct FinancialSummaryContainer: View {
    @State private var shouldPresentTransactionHistory = false

    let mocks: [FinancialSummaryModel] = [ .init(image: "melissa",
                                                 title: "Transfer sent",
                                                 description: "Funds successfully transferred to Melissa",
                                                 value: "-$ 250.00",
                                                 tag: .transfer,
                                                 date: Date()),
                                           .init(image: "ed",
                                                 title: "Payment received",
                                                 description: "Funds received from Ed Sheeran",
                                                 value: "$ 125.00",
                                                 tag: .income,
                                                 date: Date()),
                                          .init(image: "ifoodlogo",
                                                title: "Ifd* Bar do zé",
                                                description: "Restaurant",
                                                value: "-$ 30.00",
                                                tag: .expense,
                                                date: Date()),
                                          .init(image: "melissa",
                                                title: "Transfer sent",
                                                description: "Funds successfully transferred to Melissa",
                                                value: "-$ 250.00",
                                                tag: .transfer,
                                                date: Date())]
    
    var body: some View {
        VStack {
            ForEach(mocks) { transfer in
                FinancialSummary(model: transfer,
                                 hasDivider: transfer.id != mocks.last?.id)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
        .onTapGesture {
            shouldPresentTransactionHistory = true
        }
        .navigationDestination(isPresented: $shouldPresentTransactionHistory) {
            TransactionHistoryView()
        }
    }
}

#Preview {
    FinancialSummaryContainer()
}
