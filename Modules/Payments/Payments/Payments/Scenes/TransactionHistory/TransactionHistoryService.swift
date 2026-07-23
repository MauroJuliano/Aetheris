import Core
import Foundation

protocol TransactionHistoryServicing {
    func loadTransactions() async throws -> [FinancialSummaryModel]
}

final class TransactionHistoryService: TransactionHistoryServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadTransactions() async throws -> [FinancialSummaryModel] {
        let payloads: [TransactionHistoryPayload] = try await coreService.execute(TransactionHistoryEndpoint.transactions)
        return payloads.compactMap(\.model)
    }
}

private enum TransactionHistoryEndpoint {
    case transactions
}

extension TransactionHistoryEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/transactions"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .transactions:
            return Self.encodeOrEmpty(TransactionHistoryPayload.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct TransactionHistoryPayload: Codable {
    let image: String
    let title: String
    let description: String
    let value: String
    let tag: String
    let date: TimeInterval

    static let mock: [TransactionHistoryPayload] = [
        .init(image: "melissa",
              title: Strings.FinancialSummary.transferSent,
              description: Strings.FinancialSummary.transferSentDescription,
              value: "-$ 250.00",
              tag: "transfer",
              date: Date().timeIntervalSince1970),
        .init(image: "ed",
              title: Strings.FinancialSummary.paymentReceived,
              description: Strings.FinancialSummary.paymentReceivedDescription,
              value: "$ 125.00",
              tag: "income",
              date: Date().timeIntervalSince1970),
        .init(image: "NetflixLogo",
              title: Strings.FinancialSummary.netflix,
              description: Strings.FinancialSummary.subscription,
              value: "-$ 20.00",
              tag: "expense",
              date: Calendar.current.date(byAdding: .day, value: -1, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970),
        .init(image: "applelogo",
              title: Strings.FinancialSummary.appleBill,
              description: Strings.FinancialSummary.subscription,
              value: "-$ 9.00",
              tag: "expense",
              date: Calendar.current.date(byAdding: .day, value: -5, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970),
        .init(image: "ifoodlogo",
              title: Strings.FinancialSummary.ifoodBar,
              description: Strings.FinancialSummary.restaurant,
              value: "-$ 30.00",
              tag: "expense",
              date: Calendar.current.date(byAdding: .day, value: -20, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970)
    ]

    var model: FinancialSummaryModel? {
        guard let type = Self.transactionType(from: tag) else { return nil }

        return FinancialSummaryModel(
            image: image,
            title: title,
            description: description,
            value: value,
            tag: type,
            date: Date(timeIntervalSince1970: date)
        )
    }

    private static func transactionType(from token: String) -> TransactionType? {
        switch token {
        case "income":
            return .income
        case "expense":
            return .expense
        case "transfer":
            return .transfer
        default:
            return nil
        }
    }
}
