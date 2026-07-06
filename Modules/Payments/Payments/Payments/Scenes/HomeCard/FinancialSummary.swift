import SwiftUI

struct FinancialSummaryModel: Identifiable {
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
                                                          title: "Transfer sent",
                                                          description: "Funds successfully transferred to Melissa",
                                                          value: "-$ 250.00",
                                                          tag: .transfer,
                                                          date: Date())
    
    static let mock: [FinancialSummaryModel] = [
        .init(image: "melissa",
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
        .init(image: "NetflixLogo",
              title: "Netflix",
              description: "Subscription",
              value: "-$ 20.00",
              tag: .expense,
              date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()),
        .init(image: "applelogo",
              title: "Apple.Com/Bill",
              description: "Subscription",
              value: "-$ 9.00",
              tag: .expense,
              date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()),
        .init(image: "ifoodlogo",
              title: "Ifd* Bar do zé",
              description: "Restaurant",
              value: "-$ 30.00",
              tag: .expense,
              date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()),
        .init(image: "Adele",
              title: "Transfer sent",
              description: "Funds successfully transferred to Adele",
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
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now),
                  date >= weekAgo {
            return "Last Week"
        } else if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now),
                  date >= monthAgo {
            return "Last Month"
        } else {
            return "Others"
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
                .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                .padding(.trailing, 5)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .foregroundStyle(.black)
                    .font(.headline)
                    .bold()
                
                Text(model.description)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
                
                TransactionTag(type: model.tag)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(model.value)
                    .foregroundStyle(model.tag == .income ? model.tag.color : .black)
                    .bold()
                    .font(.headline)
                    .monospacedDigit()

                Text(dateLabel)
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .monospacedDigit()
            }
        }
        .padding()
        
        if hasDivider {
            Divider()
                .padding(.leading, 78)
        }
    }

    private var dateLabel: String {
        let formatter = DateFormatter()

        if Calendar.current.isDateInToday(model.date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: model.date)
        }

        if Calendar.current.isDateInYesterday(model.date) {
            return "Yesterday"
        }

        let days = Calendar.current.dateComponents([.day],
                                                   from: model.date,
                                                   to: Date()).day ?? 0

        if days < 30 {
            return "\(days) days ago"
        }

        return "\(max(1, days / 30)) month ago"
    }
}

#Preview {
    FinancialSummary(model: .previewMock)
}
