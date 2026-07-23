import AetherisDesignSystem
import SwiftUI

struct FinancialSummaryContainer: View {
    let summaries: [FinancialSummaryModel]
    let onTap: () -> Void

    init(summaries: [FinancialSummaryModel],
         onTap: @escaping () -> Void = {}) {
        self.summaries = summaries
        self.onTap = onTap
    }
    
    var body: some View {
        VStack {
            ForEach(summaries) { transfer in
                FinancialSummary(model: transfer,
                                 hasDivider: transfer.id != summaries.last?.id)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
        .onTapGesture {
            onTap()
        }
    }
}

