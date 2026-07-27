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
        try await coreService.execute(TransactionHistoryEndpoint.transactions)
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
            return Self.encodeOrEmpty(FinancialSummaryModel.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
