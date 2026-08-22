import Core
import Foundation

struct CardActivityModel: Identifiable, Codable, Equatable {
    enum ActivityType: String, Codable {
        case transfer
        case income
        case subscription
        case purchase
    }

    let id: UUID
    let cardId: UUID
    let image: String
    let type: ActivityType
    let counterparty: String
    let amount: Decimal
    let currencyCode: String
    let date: Date

    var presentationModel: FinancialSummaryModel {
        FinancialSummaryModel(
            id: id,
            cardId: cardId,
            image: image,
            title: title,
            description: description,
            value: formattedAmount,
            tag: tag,
            date: date
        )
    }

    private var title: String {
        switch type {
        case .transfer:
            Strings.FinancialSummary.transferSent
        case .income:
            Strings.FinancialSummary.paymentReceived
        case .subscription, .purchase:
            counterparty
        }
    }

    private var description: String {
        switch type {
        case .transfer:
            Strings.FinancialSummary.transferSentTo(counterparty)
        case .income:
            Strings.FinancialSummary.paymentReceivedFrom(counterparty)
        case .subscription:
            Strings.FinancialSummary.subscription
        case .purchase:
            Strings.FinancialSummary.restaurant
        }
    }

    private var tag: TransactionType {
        switch type {
        case .transfer: .transfer
        case .income: .income
        case .subscription, .purchase: .expense
        }
    }

    private var formattedAmount: String {
        let locale = LanguageManager().effectiveLanguage.locale
        return amount.formatted(.currency(code: currencyCode).locale(locale))
    }
}
