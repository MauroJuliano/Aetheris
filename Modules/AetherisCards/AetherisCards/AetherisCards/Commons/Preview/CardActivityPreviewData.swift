import AetherisDesignSystem
import Foundation

enum CardActivityPreviewData {
    private static let referenceDate = Date()

    static func dashboardSummaries() -> [FinancialSummaryModel] {
        [
            .init(
                id: TransactionMockIDs.sophieTransfer,
                cardId: CardMockIDs.standard,
                image: "sophie",
                title: Strings.FinancialSummary.transferSent,
                description: Strings.FinancialSummary.transferSentDescription,
                value: "-$ 250.00",
                tag: .transfer,
                date: referenceDate
            ),
            .init(
                id: TransactionMockIDs.ameliaPayment,
                cardId: CardMockIDs.standard,
                image: "Amelia",
                title: Strings.FinancialSummary.paymentReceived,
                description: Strings.FinancialSummary.paymentReceivedDescription,
                value: "$ 125.00",
                tag: .income,
                date: referenceDate
            ),
            .init(
                id: TransactionMockIDs.netflixSubscription,
                cardId: CardMockIDs.standard,
                image: "NetflixLogo",
                title: Strings.FinancialSummary.netflix,
                description: Strings.FinancialSummary.subscription,
                value: "-$ 20.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.appleSubscription,
                cardId: CardMockIDs.standard,
                image: "applelogo",
                title: Strings.FinancialSummary.appleBill,
                description: Strings.FinancialSummary.subscription,
                value: "-$ 9.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.ifoodPurchase,
                cardId: CardMockIDs.standard,
                image: "ifoodlogo",
                title: Strings.FinancialSummary.ifoodBar,
                description: Strings.FinancialSummary.restaurant,
                value: "-$ 30.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.goldTransfer,
                cardId: CardMockIDs.gold,
                image: "sophie",
                title: Strings.FinancialSummary.transferSent,
                description: Strings.FinancialSummary.transferSentDescription,
                value: "-$ 480.00",
                tag: .transfer,
                date: referenceDate
            ),
            .init(
                id: TransactionMockIDs.goldSubscription,
                cardId: CardMockIDs.gold,
                image: "NetflixLogo",
                title: Strings.FinancialSummary.netflix,
                description: Strings.FinancialSummary.subscription,
                value: "-$ 20.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.ameliaTransfer,
                cardId: CardMockIDs.infinite,
                image: "Amelia",
                title: Strings.FinancialSummary.transferSent,
                description: Strings.FinancialSummary.transferSentAmeliaDescription,
                value: "-$ 70.00",
                tag: .transfer,
                date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.infinitePayment,
                cardId: CardMockIDs.infinite,
                image: "Amelia",
                title: Strings.FinancialSummary.paymentReceived,
                description: Strings.FinancialSummary.paymentReceivedDescription,
                value: "$ 125.00",
                tag: .income,
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.blackAppleSubscription,
                cardId: CardMockIDs.black,
                image: "applelogo",
                title: Strings.FinancialSummary.appleBill,
                description: Strings.FinancialSummary.subscription,
                value: "-$ 9.00",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
            ),
            .init(
                id: TransactionMockIDs.blackIfoodPurchase,
                cardId: CardMockIDs.black,
                image: "ifoodlogo",
                title: Strings.FinancialSummary.ifoodBar,
                description: Strings.FinancialSummary.restaurant,
                value: "-$ 30.00",
                tag: .expense,
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
