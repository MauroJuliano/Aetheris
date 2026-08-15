import AetherisDesignSystem
import Foundation

enum CardsPreviewData {
    static let cardId = CardMockIDs.standard

    static let summaries: [FinancialSummaryModel] = CardActivityPreviewData.transactions(for: cardId)

    static let virtualCard = VirtualCardModel(
        id: UUID(uuidString: "90000000-0000-0000-0000-000000000001")!,
        physicalCardId: cardId,
        holderName: "Jorge Henrique",
        cardNumber: "4589123412349918",
        expirationDate: "09/29",
        securityCode: "872",
        brand: .visa,
        style: .standard,
        availableLimit: 2_750,
        totalLimit: 5_000,
        monthlyExpenses: 250,
        isActive: true
    )

    static let cardLock = CardLockModel(
        id: cardId,
        holderName: "Jorge Henrique",
        lastFourDigits: "4421",
        expirationDate: "09/29",
        brand: .visa,
        style: .standard,
        isBlocked: false
    )

    static let blockedCardLock = CardLockModel(
        id: CardMockIDs.infinite,
        holderName: "Marina Souza",
        lastFourDigits: "7676",
        expirationDate: "02/30",
        brand: .mastercard,
        style: .infinite,
        isBlocked: true
    )

    static let invoice = CurrentInvoiceModel(
        id: UUID(uuidString: "90000000-0000-0000-0000-000000000002")!,
        cardId: cardId,
        amount: 350,
        status: .open,
        dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
        bestPurchaseDate: Calendar.current.date(byAdding: .day, value: 15, to: Date()) ?? Date(),
        totalLimit: 5_000,
        availableLimit: 2_750,
        usedLimit: 2_250,
        details: CurrentInvoiceDetailsModel(
            purchasesSubtotal: 318.50,
            otherCharges: 31.50,
            discountsAndCredits: 0,
            total: 350
        ),
        spendingSummary: InvoiceSpendingSummaryModel(
            totalSpent: 2_250,
            installmentPurchases: 1_200,
            oneTimePurchases: 1_050
        )
    )

    static let paymentMethod = PaymentMethodSummaryModel(
        id: UUID(uuidString: "90000000-0000-0000-0000-000000000003")!,
        title: "Aetheris Visa",
        subtitle: "Virtual card",
        lastFourDigits: "4421",
        icon: "creditcard"
    )

    static let transaction = TransactionDetailsModel(
        id: UUID(uuidString: "90000000-0000-0000-0000-000000000004")!,
        title: "Netflix",
        subtitle: "NETFLIX.COM",
        amount: 20,
        currencyCode: "USD",
        kind: .subscription,
        status: .completed,
        date: Date(),
        transactionCode: "TXN-84K2-19X8-7P3A",
        note: "Family plan",
        imageName: "NetflixLogo",
        imageURL: nil,
        incomingPaymentDetails: nil,
        transferDetails: nil,
        merchantDetails: nil,
        subscriptionDetails: SubscriptionDetailsModel(
            merchantId: UUID(uuidString: "90000000-0000-0000-0000-000000000005")!,
            merchantName: "Netflix",
            merchantDescriptor: "NETFLIX.COM",
            merchantImageName: "NetflixLogo",
            category: "Entertainment",
            billingFrequency: .monthly,
            lastPaymentDate: Date(),
            nextExpectedPaymentDate: Calendar.current.date(byAdding: .month, value: 1, to: Date()),
            expectedAmount: 20,
            currencyCode: "USD",
            paymentMethod: paymentMethod,
            paymentHistory: [
                SubscriptionPaymentHistoryModel(
                    id: UUID(uuidString: "90000000-0000-0000-0000-000000000006")!,
                    date: Date(),
                    amount: 20,
                    currencyCode: "USD",
                    status: .completed
                ),
                SubscriptionPaymentHistoryModel(
                    id: UUID(uuidString: "90000000-0000-0000-0000-000000000007")!,
                    date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(),
                    amount: 20,
                    currencyCode: "USD",
                    status: .completed
                )
            ],
            isRecurringPaymentDetected: true,
            merchantIsBlocked: false
        ),
        refundDetails: nil,
        invoicePaymentDetails: nil,
        availableActions: [.share, .download, .addNote, .reportIssue]
    )
}
