import Core
import Foundation

protocol TransactionDetailsServicing {
    func fetchTransactionDetails(transactionId: UUID) async throws -> TransactionDetailsModel
    func downloadReceipt(transactionId: UUID) async throws -> URL
    func updateNote(transactionId: UUID, note: String?) async throws -> TransactionDetailsModel
}

final class TransactionDetailsService: TransactionDetailsServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func fetchTransactionDetails(transactionId: UUID) async throws -> TransactionDetailsModel {
        try await coreService.execute(TransactionDetailsEndpoint.details(transactionId: transactionId))
    }

    func downloadReceipt(transactionId: UUID) async throws -> URL {
        let response: TransactionReceiptResponse = try await coreService.execute(
            TransactionDetailsEndpoint.receipt(transactionId: transactionId)
        )
        return response.receiptURL
    }

    func updateNote(transactionId: UUID, note: String?) async throws -> TransactionDetailsModel {
        let request = TransactionNoteUpdateRequest(note: note)
        return try await coreService.execute(
            TransactionDetailsEndpoint.updateNote(transactionId: transactionId, request: request)
        )
    }
}

private struct TransactionReceiptResponse: Codable {
    let receiptURL: URL
}

private struct TransactionNoteUpdateRequest: Codable {
    let note: String?
}

private enum TransactionDetailsEndpoint {
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

enum TransactionDetailsMockStore {
    private static let defaultCardId = UUID(uuidString: "01010101-0101-0101-0101-010101010101")!
    private static let defaultVirtualCardId = UUID(uuidString: "02020202-0202-0202-0202-020202020202")!

    static func transaction(for transactionId: UUID, note: String? = nil) -> TransactionDetailsModel {
        switch transactionId {
        case TransactionMockIDs.melissaTransfer:
            return transfer(
                id: transactionId,
                title: "Melissa",
                subtitle: "Bank transfer",
                amount: 250,
                imageName: "melissa",
                recipientName: "Melissa Stone",
                note: note
            )
        case TransactionMockIDs.edPayment:
            return incomingPayment(id: transactionId, note: note)
        case TransactionMockIDs.netflixSubscription:
            return netflixSubscription(id: transactionId, note: note)
        case TransactionMockIDs.appleSubscription:
            return appleSubscription(id: transactionId, note: note)
        case TransactionMockIDs.ifoodPurchase:
            return purchase(id: transactionId, note: note)
        case TransactionMockIDs.adeleTransfer:
            return transfer(
                id: transactionId,
                title: "Adele",
                subtitle: "Bank transfer",
                amount: 70,
                imageName: "Adele",
                recipientName: "Adele Roberts",
                note: note
            )
        case TransactionMockIDs.refund:
            return refund(id: transactionId, note: note)
        case TransactionMockIDs.invoicePayment:
            return invoicePayment(id: transactionId, note: note)
        default:
            return netflixSubscription(id: transactionId, note: note)
        }
    }
}

private extension TransactionDetailsMockStore {
    static var baseActions: [TransactionAction] {
        [.share, .download, .addNote, .reportIssue]
    }

    static func incomingPayment(id: UUID, note: String?) -> TransactionDetailsModel {
        let senderId = UUID(uuidString: "20000000-0000-0000-0000-000000000002")!
        return TransactionDetailsModel(
            id: id,
            title: "Ed Sheeran",
            subtitle: "Payment received",
            amount: 125,
            currencyCode: "USD",
            kind: .incomingPayment,
            status: .completed,
            date: Date(),
            transactionCode: "TXN-ED-125-2026",
            note: note,
            imageName: "ed",
            imageURL: nil,
            incomingPaymentDetails: IncomingPaymentDetailsModel(
                senderId: senderId,
                senderName: "Ed Sheeran",
                senderContact: "ed@email.com",
                method: "Instant payment",
                methodDetails: "Aetheris account",
                reference: "Dinner split"
            ),
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: nil,
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func transfer(
        id: UUID,
        title: String,
        subtitle: String,
        amount: Decimal,
        imageName: String,
        recipientName: String,
        note: String?
    ) -> TransactionDetailsModel {
        let recipientId = UUID(uuidString: "20000000-0000-0000-0000-000000000001")!
        return TransactionDetailsModel(
            id: id,
            title: title,
            subtitle: subtitle,
            amount: amount,
            currencyCode: "USD",
            kind: .outgoingTransfer,
            status: .completed,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            transactionCode: "TXN-TRF-\(id.uuidString.prefix(4))",
            note: note,
            imageName: imageName,
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: TransferDetailsModel(
                recipientId: recipientId,
                recipientName: recipientName,
                recipientContact: "contact@aetheris.app",
                destinationInstitution: "Aetheris Bank",
                method: "Instant transfer",
                reference: "Personal transfer"
            ),
            merchantDetails: nil,
            subscriptionDetails: nil,
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func netflixSubscription(id: UUID, note: String?) -> TransactionDetailsModel {
        let merchantId = UUID(uuidString: "30000000-0000-0000-0000-000000000003")!
        return TransactionDetailsModel(
            id: id,
            title: "Netflix",
            subtitle: "NETFLIX.COM",
            amount: 20,
            currencyCode: "USD",
            kind: .subscription,
            status: .completed,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            transactionCode: "TXN-84K2-19X8-7P3A",
            note: note,
            imageName: "NetflixLogo",
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: subscriptionDetails(merchantId: merchantId, merchantName: "Netflix", amount: 20),
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func appleSubscription(id: UUID, note: String?) -> TransactionDetailsModel {
        let merchantId = UUID(uuidString: "30000000-0000-0000-0000-000000000004")!
        return TransactionDetailsModel(
            id: id,
            title: "Apple",
            subtitle: "APPLE.COM/BILL",
            amount: 9,
            currencyCode: "USD",
            kind: .subscription,
            status: .completed,
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
            transactionCode: "TXN-APL-9-2026",
            note: note,
            imageName: "applelogo",
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: subscriptionDetails(merchantId: merchantId, merchantName: "Apple", amount: 9),
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func purchase(id: UUID, note: String?) -> TransactionDetailsModel {
        let merchantId = UUID(uuidString: "30000000-0000-0000-0000-000000000005")!
        let method = PaymentMethodSummaryModel(
            id: defaultCardId,
            title: "Aetheris Visa",
            subtitle: "Physical card",
            lastFourDigits: "4421",
            icon: "creditcard"
        )
        return TransactionDetailsModel(
            id: id,
            title: "iFood",
            subtitle: "Restaurant",
            amount: 30,
            currencyCode: "USD",
            kind: .purchase,
            status: .completed,
            date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date(),
            transactionCode: "TXN-IFOOD-30-2026",
            note: note,
            imageName: "ifoodlogo",
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: MerchantDetailsModel(
                merchantId: merchantId,
                merchantName: "iFood",
                descriptor: "IFOOD RESTAURANT",
                category: "Restaurant",
                location: "Sao Paulo, Brazil",
                paymentMethod: method
            ),
            subscriptionDetails: nil,
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func refund(id: UUID, note: String?) -> TransactionDetailsModel {
        return TransactionDetailsModel(
            id: id,
            title: "Refund",
            subtitle: "Original purchase refunded",
            amount: 30,
            currencyCode: "USD",
            kind: .refund,
            status: .refunded,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            transactionCode: "TXN-REF-30-2026",
            note: note,
            imageName: nil,
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: nil,
            refundDetails: RefundDetailsModel(
                originalTransactionId: TransactionMockIDs.ifoodPurchase,
                originalMerchantName: "iFood",
                originalPurchaseDate: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date(),
                refundReason: "Merchant refund",
                expectedAvailabilityDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())
            ),
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func invoicePayment(id: UUID, note: String?) -> TransactionDetailsModel {
        let paymentMethod = PaymentMethodSummaryModel(
            id: UUID(uuidString: "40000000-0000-0000-0000-000000000001")!,
            title: "Aetheris checking",
            subtitle: "Account balance",
            lastFourDigits: nil,
            icon: "building.columns"
        )
        return TransactionDetailsModel(
            id: id,
            title: "Invoice payment",
            subtitle: "Aetheris Visa",
            amount: 350,
            currencyCode: "USD",
            kind: .invoicePayment,
            status: .completed,
            date: Date(),
            transactionCode: "TXN-INV-350-2026",
            note: note,
            imageName: nil,
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: nil,
            refundDetails: nil,
            invoicePaymentDetails: InvoicePaymentDetailsModel(
                invoiceId: UUID(uuidString: "50000000-0000-0000-0000-000000000001")!,
                cardId: defaultCardId,
                cardName: "Aetheris Visa",
                billingPeriod: "August 2026",
                paidAmount: 350,
                currencyCode: "USD",
                paymentMethod: paymentMethod,
                confirmationCode: "PAY-9K2M-2026"
            ),
            availableActions: [.share, .download]
        )
    }

    static func subscriptionDetails(
        merchantId: UUID,
        merchantName: String,
        amount: Decimal
    ) -> SubscriptionDetailsModel {
        SubscriptionDetailsModel(
            merchantId: merchantId,
            merchantName: merchantName,
            merchantDescriptor: "\(merchantName.uppercased()).COM",
            merchantImageName: nil,
            category: "Entertainment",
            billingFrequency: .monthly,
            lastPaymentDate: Date(),
            nextExpectedPaymentDate: Calendar.current.date(byAdding: .month, value: 1, to: Date()),
            expectedAmount: amount,
            currencyCode: "USD",
            paymentMethod: PaymentMethodSummaryModel(
                id: defaultVirtualCardId,
                title: "Aetheris Visa",
                subtitle: "Virtual card",
                lastFourDigits: "4421",
                icon: "creditcard"
            ),
            paymentHistory: [
                SubscriptionPaymentHistoryModel(id: UUID(), date: Date(), amount: amount, currencyCode: "USD", status: .completed),
                SubscriptionPaymentHistoryModel(
                    id: UUID(),
                    date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(),
                    amount: amount,
                    currencyCode: "USD",
                    status: .completed
                ),
                SubscriptionPaymentHistoryModel(
                    id: UUID(),
                    date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date(),
                    amount: amount,
                    currencyCode: "USD",
                    status: .completed
                )
            ],
            isRecurringPaymentDetected: true,
            merchantIsBlocked: false
        )
    }
}
