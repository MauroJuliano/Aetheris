import AetherisDesignSystem
import SwiftUI

struct FinancialSummary: View {
    var model: FinancialSummaryModel
    var hasDivider: Bool
    
    init(model: FinancialSummaryModel,
         hasDivider: Bool = true) {
        self.model = model
        self.hasDivider = hasDivider
    }
    
    var body: some View {
        HStack {
            Image(model.image)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                .appShadow(AppShadow.elevated)
                .padding(.trailing, AppSpacing.xxSmall)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.headline)
                    .bold()
                
                Text(model.description)
                    .foregroundStyle(Color.textSecondaryColor)
                    .font(AppTypography.subheadline)
                    .monospacedDigit()
                
                TransactionTag(
                    model: .init(
                        title: model.tag.title,
                        icon: model.tag.icon,
                        color: model.tag.color
                    )
                )
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: AppSpacing.xxSmall) {
                Text(model.value)
                    .foregroundStyle(model.tag == .income ? model.tag.color : Color.textPrimary)
                    .bold()
                    .font(AppTypography.headline)
                    .monospacedDigit()

                Text(dateLabel)
                    .foregroundStyle(Color.textSecondaryColor)
                    .font(AppTypography.footnote)
                    .monospacedDigit()
            }
        }
        .appListCellRow(
            hasDivider: hasDivider,
            horizontalPadding: AppSpacing.medium,
            verticalPadding: AppSpacing.medium
        )
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            FinancialSummarySkeleton(hasDivider: hasDivider)
        } else {
            self
        }
    }

    private var dateLabel: String {
        FinancialSummaryPresentation.dateLabel(for: model.date)
    }
}

#Preview {
    FinancialSummary(
        model: CardsPreviewData.summaries[0]
    )
    .padding()
    .appScreenBackground()
}
