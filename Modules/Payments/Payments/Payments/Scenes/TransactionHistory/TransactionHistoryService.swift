import AetherisDesignSystem
import Core
import Foundation

protocol TransactionHistoryServicing {
    func loadTransactions() async throws -> [FinancialSummaryModel]
}

final class TransactionHistoryService: TransactionHistoryServicing {
    private let coreService: any HasCoreService
    private let cardId: UUID

    init(coreService: any HasCoreService, cardId: UUID) {
        self.coreService = coreService
        self.cardId = cardId
    }

    func loadTransactions() async throws -> [FinancialSummaryModel] {
        try await coreService.execute(TransactionHistoryEndpoint.transactions(cardId: cardId))
    }
}

private enum TransactionHistoryEndpoint {
    case transactions(cardId: UUID)
}

extension TransactionHistoryEndpoint: Endpoint {
    var path: String {
        switch self {
        case .transactions(let cardId):
            return "/payments/transactions?cardId=\(cardId.uuidString)"
        }
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .transactions(let cardId):
            return Self.encodeOrEmpty(Self.mockTransactions(for: cardId))
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }

    private static func mockTransactions(for cardId: UUID) -> [FinancialSummaryModel] {
        switch cardId {
        case CardMockIDs.standard:
            return [
                .init(
                    cardId: cardId,
                    image: "melissa",
                    title: Strings.FinancialSummary.transferSent,
                    description: Strings.FinancialSummary.transferSentDescription,
                    value: "-$ 250.00",
                    tag: .transfer,
                    date: Date()
                ),
                .init(
                    cardId: cardId,
                    image: "ed",
                    title: Strings.FinancialSummary.paymentReceived,
                    description: Strings.FinancialSummary.paymentReceivedDescription,
                    value: "$ 125.00",
                    tag: .income,
                    date: Date()
                ),
                .init(
                    cardId: cardId,
                    image: "NetflixLogo",
                    title: Strings.FinancialSummary.netflix,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 20.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "applelogo",
                    title: Strings.FinancialSummary.appleBill,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 9.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "ifoodlogo",
                    title: Strings.FinancialSummary.ifoodBar,
                    description: Strings.FinancialSummary.restaurant,
                    value: "-$ 30.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
                )
            ]

        case CardMockIDs.gold:
            return [
                .init(
                    cardId: cardId,
                    image: "melissa",
                    title: Strings.FinancialSummary.transferSent,
                    description: Strings.FinancialSummary.transferSentDescription,
                    value: "-$ 480.00",
                    tag: .transfer,
                    date: Date()
                ),
                .init(
                    cardId: cardId,
                    image: "NetflixLogo",
                    title: Strings.FinancialSummary.netflix,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 20.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
                )
            ]

        case CardMockIDs.infinite:
            return [
                .init(
                    cardId: cardId,
                    image: "Adele",
                    title: Strings.FinancialSummary.transferSent,
                    description: Strings.FinancialSummary.transferSentAdeleDescription,
                    value: "-$ 70.00",
                    tag: .transfer,
                    date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "ed",
                    title: Strings.FinancialSummary.paymentReceived,
                    description: Strings.FinancialSummary.paymentReceivedDescription,
                    value: "$ 125.00",
                    tag: .income,
                    date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
                )
            ]

        case CardMockIDs.black:
            return [
                .init(
                    cardId: cardId,
                    image: "applelogo",
                    title: Strings.FinancialSummary.appleBill,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 9.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "ifoodlogo",
                    title: Strings.FinancialSummary.ifoodBar,
                    description: Strings.FinancialSummary.restaurant,
                    value: "-$ 30.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
                )
            ]

        default:
            return [
                .init(
                    cardId: cardId,
                    image: "melissa",
                    title: Strings.FinancialSummary.transferSent,
                    description: Strings.FinancialSummary.transferSentDescription,
                    value: "-$ 250.00",
                    tag: .transfer,
                    date: Date()
                ),
                .init(
                    cardId: cardId,
                    image: "ed",
                    title: Strings.FinancialSummary.paymentReceived,
                    description: Strings.FinancialSummary.paymentReceivedDescription,
                    value: "$ 125.00",
                    tag: .income,
                    date: Date()
                ),
                .init(
                    cardId: cardId,
                    image: "NetflixLogo",
                    title: Strings.FinancialSummary.netflix,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 20.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "applelogo",
                    title: Strings.FinancialSummary.appleBill,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 9.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "ifoodlogo",
                    title: Strings.FinancialSummary.ifoodBar,
                    description: Strings.FinancialSummary.restaurant,
                    value: "-$ 30.00",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
                ),
                .init(
                    cardId: cardId,
                    image: "Adele",
                    title: Strings.FinancialSummary.transferSent,
                    description: Strings.FinancialSummary.transferSentAdeleDescription,
                    value: "-$ 70.00",
                    tag: .transfer,
                    date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date()
                )
            ]
        }
    }
}
