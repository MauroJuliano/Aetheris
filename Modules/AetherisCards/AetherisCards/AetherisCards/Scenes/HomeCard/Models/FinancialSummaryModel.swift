import Foundation

struct FinancialSummaryModel: Identifiable, Codable {
    var id: UUID
    var cardId: UUID?
    var image: String
    var title: String
    var description: String
    var tag: TransactionType
    var value: String
    var date: Date

    init(id: UUID = UUID(),
         cardId: UUID? = nil,
         image: String,
         title: String,
         description: String,
         value: String,
         tag: TransactionType,
         date: Date) {
        self.id = id
        self.cardId = cardId
        self.image = image
        self.title = title
        self.description = description
        self.value = value
        self.tag = tag
        self.date = date
    }

    init(
        cardId: UUID? = nil,
        image: String,
        title: String,
        description: String,
        value: String,
        tag: TransactionType,
        date: Date
    ) {
        self.init(
            id: UUID(),
            cardId: cardId,
            image: image,
            title: title,
            description: description,
            value: value,
            tag: tag,
            date: date
        )
    }
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
