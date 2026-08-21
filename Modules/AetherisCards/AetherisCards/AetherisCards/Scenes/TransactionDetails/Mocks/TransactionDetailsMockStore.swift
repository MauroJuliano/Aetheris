import AetherisDesignSystem
import Foundation

enum TransactionDetailsMockStore {
    private static let defaultCardId = UUID(uuidString: "01010101-0101-0101-0101-010101010101")!
    private static let defaultVirtualCardId = UUID(uuidString: "02020202-0202-0202-0202-020202020202")!

    static func transaction(for transactionId: UUID, note: String? = nil) -> TransactionDetailsModel {
        switch transactionId {
        case TransactionMockIDs.sophieTransfer:
            return transfer(
                id: transactionId,
                title: "Sophie Keller",
                subtitle: Strings.Mock.bankTransfer,
                amount: 250,
                imageName: "sophie",
                recipientName: "Sophie Keller",
                note: note
            )
        case TransactionMockIDs.ameliaPayment:
            return incomingPayment(id: transactionId, note: note)
        case TransactionMockIDs.netflixSubscription:
            return netflixSubscription(id: transactionId, note: note)
        case TransactionMockIDs.appleSubscription:
            return appleSubscription(id: transactionId, note: note)
        case TransactionMockIDs.ifoodPurchase:
            return purchase(id: transactionId, note: note)
        case TransactionMockIDs.ameliaTransfer:
            return transfer(
                id: transactionId,
                title: "Amelia Thompson",
                subtitle: Strings.Mock.bankTransfer,
                amount: 70,
                imageName: "Amelia",
                recipientName: "Amelia Thompson",
                note: note
            )
        case TransactionMockIDs.refund:
            return refund(id: transactionId, note: note)
        case TransactionMockIDs.invoicePayment:
            return invoicePayment(id: transactionId, note: note)
        default:
            return purchase(
                id: transactionId,
                title: Strings.Mock.transaction,
                subtitle: Strings.Mock.unknownMerchant,
                amount: 0,
                note: note
            )
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
            title: "Amelia Thompson",
            subtitle: Strings.Mock.paymentReceived,
            amount: 125,
            currencyCode: "USD",
            kind: .incomingPayment,
            status: .completed,
            date: Date(),
            transactionCode: "TXN-ED-125-2026",
            note: note,
            imageName: "Amelia",
            imageURL: nil,
            incomingPaymentDetails: IncomingPaymentDetailsModel(
                senderId: senderId,
                senderName: "Amelia Thompson",
                senderContact: "amelia.thompson@aetheris.app",
                method: Strings.Mock.instantPayment,
                methodDetails: Strings.Mock.aetherisAccount,
                reference: Strings.Mock.dinnerSplit
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
                method: Strings.Mock.instantTransfer,
                reference: Strings.Mock.personalTransfer
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

    static func purchase(
        id: UUID,
        title: String = "iFood",
        subtitle: String = Strings.Mock.restaurant,
        amount: Decimal = 30,
        note: String?
    ) -> TransactionDetailsModel {
        let merchantId = UUID(uuidString: "30000000-0000-0000-0000-000000000005")!
        let method = PaymentMethodSummaryModel(
            id: defaultCardId,
            title: "Aetheris Visa",
                subtitle: Strings.Mock.physicalCard,
            lastFourDigits: "4421",
            icon: "creditcard"
        )
        return TransactionDetailsModel(
            id: id,
            title: title,
            subtitle: subtitle,
            amount: amount,
            currencyCode: "USD",
            kind: .purchase,
            status: .completed,
            date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date(),
            transactionCode: "TXN-IFOOD-30-2026",
            note: note,
            imageName: title == "iFood" ? "ifoodlogo" : nil,
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: MerchantDetailsModel(
                merchantId: merchantId,
                merchantName: "iFood",
                descriptor: "IFOOD RESTAURANT",
                category: Strings.Mock.restaurant,
                location: Strings.Mock.saoPauloBrazil,
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
            title: Strings.Mock.refund,
            subtitle: Strings.Mock.originalPurchaseRefunded,
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
                refundReason: Strings.Mock.merchantRefund,
                expectedAvailabilityDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())
            ),
            invoicePaymentDetails: nil,
            availableActions: baseActions
        )
    }

    static func invoicePayment(id: UUID, note: String?) -> TransactionDetailsModel {
        let paymentMethod = PaymentMethodSummaryModel(
            id: UUID(uuidString: "40000000-0000-0000-0000-000000000001")!,
            title: Strings.Mock.aetherisChecking,
            subtitle: Strings.Mock.accountBalance,
            lastFourDigits: nil,
            icon: "building.columns"
        )
        return TransactionDetailsModel(
            id: id,
            title: Strings.Mock.invoicePayment,
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
                billingPeriod: Strings.Mock.august2026,
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
            category: Strings.Mock.entertainment,
            billingFrequency: .monthly,
            lastPaymentDate: Date(),
            nextExpectedPaymentDate: Calendar.current.date(byAdding: .month, value: 1, to: Date()),
            expectedAmount: amount,
            currencyCode: "USD",
            paymentMethod: PaymentMethodSummaryModel(
                id: defaultVirtualCardId,
                title: "Aetheris Visa",
                subtitle: Strings.Mock.virtualCard,
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
