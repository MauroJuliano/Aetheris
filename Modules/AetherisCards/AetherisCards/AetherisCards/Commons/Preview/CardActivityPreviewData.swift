import AetherisDesignSystem
import Foundation

enum CardActivityPreviewData {
    private static let referenceDate = Date()

    static func dashboardSummaries() -> [FinancialSummaryModel] {
        dashboardActivities().map(\.presentationModel)
    }

    static func dashboardActivities() -> [CardActivityModel] {
        [
            .init(
                id: TransactionMockIDs.sophieTransfer,
                cardId: CardMockIDs.standard,
                image: "sophie",
                type: .transfer,
                counterparty: "Sophie Keller",
                amount: -250,
                currencyCode: "USD",
                date: referenceDate
            ),
            .init(
                id: TransactionMockIDs.ameliaPayment,
                cardId: CardMockIDs.standard,
                image: "Amelia",
                type: .income,
                counterparty: "Amelia Thompson",
                amount: 125,
                currencyCode: "USD",
                date: referenceDate
            ),
            .init(
                id: TransactionMockIDs.netflixSubscription,
                cardId: CardMockIDs.standard,
                image: "NetflixLogo",
                type: .subscription,
                counterparty: "Netflix",
                amount: -20,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.appleSubscription,
                cardId: CardMockIDs.standard,
                image: "applelogo",
                type: .subscription,
                counterparty: "Apple.Com/Bill",
                amount: -9,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.ifoodPurchase,
                cardId: CardMockIDs.standard,
                image: "ifoodlogo",
                type: .purchase,
                counterparty: "Ifd* Joe's Bar",
                amount: -30,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.goldTransfer,
                cardId: CardMockIDs.gold,
                image: "sophie",
                type: .transfer,
                counterparty: "Sophie Keller",
                amount: -480,
                currencyCode: "USD",
                date: referenceDate
            ),
            .init(
                id: TransactionMockIDs.goldSubscription,
                cardId: CardMockIDs.gold,
                image: "NetflixLogo",
                type: .subscription,
                counterparty: "Netflix",
                amount: -20,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.ameliaTransfer,
                cardId: CardMockIDs.infinite,
                image: "Amelia",
                type: .transfer,
                counterparty: "Amelia Thompson",
                amount: -70,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.infinitePayment,
                cardId: CardMockIDs.infinite,
                image: "Amelia",
                type: .income,
                counterparty: "Amelia Thompson",
                amount: 125,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.blackAppleSubscription,
                cardId: CardMockIDs.black,
                image: "applelogo",
                type: .subscription,
                counterparty: "Apple.Com/Bill",
                amount: -9,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.blackIfoodPurchase,
                cardId: CardMockIDs.black,
                image: "ifoodlogo",
                type: .purchase,
                counterparty: "Ifd* Joe's Bar",
                amount: -30,
                currencyCode: "USD",
                date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
            )
        ]
    }

    static func transactions(for cardId: UUID) -> [FinancialSummaryModel] {
        switch cardId {
        case CardMockIDs.standard:
            return dashboardSummaries().filter { $0.cardId == CardMockIDs.standard }
        case CardMockIDs.gold:
            return dashboardSummaries().filter { $0.cardId == CardMockIDs.gold }
        case CardMockIDs.infinite:
            return dashboardSummaries().filter { $0.cardId == CardMockIDs.infinite }
        case CardMockIDs.black:
            return dashboardSummaries().filter { $0.cardId == CardMockIDs.black }
        default:
            return dashboardSummaries().filter { $0.cardId == CardMockIDs.standard }
        }
    }
}
