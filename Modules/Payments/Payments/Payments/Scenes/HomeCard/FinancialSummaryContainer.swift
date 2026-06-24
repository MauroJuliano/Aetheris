import AetherisDesignSystem
import SwiftUI

struct FinancialSummaryContainer: View {
    let mocks: [FinancialSummaryModel] = [.init(image: "NetflixLogo",
                                                title: "Netflix",
                                                description: "Subscription",
                                                value: "$ 20.00"),
                                          .init(image: "applelogo",
                                                title: "Apple.Com/Bill",
                                                description: "Subscription",
                                                value: "$ 9.00"),
                                          .init(image: "ifoodlogo",
                                                title: "Ifd* Bar do zé",
                                                description: "Restaurant",
                                                value: "$ 30.00"),
                                          .init(image: "melissa",
                                                title: "Transfer sent",
                                                description: "Funds successfully transferred to Melissa",
                                                value: "$ 250.00")]
    
    var body: some View {
        VStack {
            ForEach(mocks) { transfer in
                FinancialSummary(model: transfer,
                                 hasDivider: transfer.id != mocks.last?.id)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 12, y: 12)
        )
    }
}

#Preview {
    FinancialSummaryContainer()
}
