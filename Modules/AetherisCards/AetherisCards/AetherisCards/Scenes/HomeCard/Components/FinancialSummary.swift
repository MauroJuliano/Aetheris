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
                
                TransactionTag(type: model.tag)
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

    private var dateLabel: String {
        let formatter = DateFormatter()

        if Calendar.current.isDateInToday(model.date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: model.date)
        }

        if Calendar.current.isDateInYesterday(model.date) {
            return Strings.Notifications.sectionYesterday
        }

        let days = Calendar.current.dateComponents([.day],
                                                   from: model.date,
                                                   to: Date()).day ?? 0

        if days < 30 {
            return Strings.FinancialSummary.daysAgo(days)
        }

        return Strings.FinancialSummary.monthAgo(max(1, days / 30))
    }
}

#Preview {
    FinancialSummary(
        model: CardsPreviewData.summaries[0]
    )
    .padding()
    .appScreenBackground()
}
