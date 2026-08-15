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
            return Self.encodeOrEmpty(CardActivityPreviewData.transactions(for: cardId))
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }

}
