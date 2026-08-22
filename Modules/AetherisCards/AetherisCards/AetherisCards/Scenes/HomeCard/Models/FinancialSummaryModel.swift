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
        FinancialSummaryPresentation.section(for: date)
    }
}
