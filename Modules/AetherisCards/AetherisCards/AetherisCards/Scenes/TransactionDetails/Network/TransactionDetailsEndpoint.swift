import Core
import Foundation

struct TransactionReceiptResponse: Codable {
    let receiptURL: URL
}
struct TransactionNoteUpdateRequest: Codable {
    let note: String?
}

enum TransactionDetailsEndpoint {
    case details(transactionId: UUID)
    case receipt(transactionId: UUID)
    case updateNote(transactionId: UUID, request: TransactionNoteUpdateRequest)
}

extension TransactionDetailsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .details(let transactionId):
            return "/payments/transactions/\(transactionId.uuidString)"
        case .receipt(let transactionId):
            return "/payments/transactions/\(transactionId.uuidString)/receipt"
        case .updateNote(let transactionId, _):
            return "/payments/transactions/\(transactionId.uuidString)/note"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .details, .receipt:
            return .get
        case .updateNote:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .details, .receipt:
            return nil
        case .updateNote(_, let request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .details(let transactionId):
            return Self.encodeOrEmpty(TransactionDetailsMockStore.transaction(for: transactionId))
        case .receipt(let transactionId):
            return Self.encodeOrEmpty(
                TransactionReceiptResponse(
                    receiptURL: URL(fileURLWithPath: "/tmp/transaction-\(transactionId.uuidString)-receipt.pdf")
                )
            )
        case .updateNote(let transactionId, let request):
            let transaction = TransactionDetailsMockStore.transaction(for: transactionId, note: request.note)
            return Self.encodeOrEmpty(transaction)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
