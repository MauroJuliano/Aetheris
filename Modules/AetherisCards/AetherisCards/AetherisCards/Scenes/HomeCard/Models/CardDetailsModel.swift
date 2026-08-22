import Foundation

struct CardDetailsModel: Identifiable, Codable, Equatable {
    let id: UUID
    let cardId: UUID
    let availableLimit: Decimal
    let totalLimit: Decimal
    let currentInvoice: Decimal
    let invoiceStatus: String
    let dueDate: Date
    let isBlocked: Bool

    init(
        id: UUID = UUID(),
        cardId: UUID,
        availableLimit: Decimal,
        totalLimit: Decimal,
        currentInvoice: Decimal,
        invoiceStatus: String,
        dueDate: Date,
        isBlocked: Bool
    ) {
        self.id = id
        self.cardId = cardId
        self.availableLimit = availableLimit
        self.totalLimit = totalLimit
        self.currentInvoice = currentInvoice
        self.invoiceStatus = invoiceStatus
        self.dueDate = dueDate
        self.isBlocked = isBlocked
    }

    var usedLimitProgress: Double {
        guard totalLimit > 0 else {
            return 0
        }

        let usedLimit = max(totalLimit - availableLimit, 0)

        return min(
            max(
                NSDecimalNumber(decimal: usedLimit / totalLimit).doubleValue,
                0
            ),
            1
        )
    }

    private static let placeholderCardId = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!

    static func placeholder(cardId: UUID? = nil) -> CardDetailsModel {
        let resolvedCardId = cardId ?? placeholderCardId

        return CardDetailsModel(
            id: resolvedCardId,
            cardId: resolvedCardId,
            availableLimit: 0,
            totalLimit: 0,
            currentInvoice: 0,
            invoiceStatus: "",
            dueDate: .distantPast,
            isBlocked: false
        )
    }
}
