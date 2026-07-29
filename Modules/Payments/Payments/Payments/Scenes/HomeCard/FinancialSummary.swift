import AetherisDesignSystem
import SwiftUI

struct FinancialSummaryModel: Identifiable, Codable {
    var id: UUID
    var image: String
    var title: String
    var description: String
    var tag: TransactionType
    var value: String
    var date: Date
    
    init(id: UUID = UUID(),
         image: String,
         title: String,
         description: String,
         value: String,
         tag: TransactionType,
         date: Date) {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
        self.value = value
        self.tag = tag
        self.date = date
    }
    
    static let previewMock: FinancialSummaryModel = .init(image: "melissa",
                                                          title: Strings.FinancialSummary.transferSent,
                                                          description: Strings.FinancialSummary.transferSentDescription,
                                                          value: "-$ 250.00",
                                                          tag: .transfer,
                                                          date: Date())
    
    static let mock: [FinancialSummaryModel] = [
        .init(image: "melissa",
              title: Strings.FinancialSummary.transferSent,
              description: Strings.FinancialSummary.transferSentDescription,
              value: "-$ 250.00",
              tag: .transfer,
              date: Date()),
        .init(image: "ed",
              title: Strings.FinancialSummary.paymentReceived,
              description: Strings.FinancialSummary.paymentReceivedDescription,
              value: "$ 125.00",
              tag: .income,
              date: Date()),
        .init(image: "NetflixLogo",
              title: Strings.FinancialSummary.netflix,
              description: Strings.FinancialSummary.subscription,
              value: "-$ 20.00",
              tag: .expense,
              date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()),
        .init(image: "applelogo",
              title: Strings.FinancialSummary.appleBill,
              description: Strings.FinancialSummary.subscription,
              value: "-$ 9.00",
              tag: .expense,
              date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()),
        .init(image: "ifoodlogo",
              title: Strings.FinancialSummary.ifoodBar,
              description: Strings.FinancialSummary.restaurant,
              value: "-$ 30.00",
              tag: .expense,
              date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()),
        .init(image: "Adele",
              title: Strings.FinancialSummary.transferSent,
              description: Strings.FinancialSummary.transferSentAdeleDescription,
              value: "-$ 70.00",
              tag: .transfer,
              date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date())
    ]
}


extension FinancialSummaryModel {
    var section: String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return Strings.Notifications.sectionToday
        } else if calendar.isDateInYesterday(date) {
            return Strings.Notifications.sectionYesterday
        } else if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now),
                  date >= weekAgo {
            return Strings.Notifications.sectionLastWeek
        } else if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now),
                  date >= monthAgo {
            return Strings.Notifications.sectionLastMonth
        } else {
            return Strings.Notifications.sectionOthers
        }
    }
}

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
