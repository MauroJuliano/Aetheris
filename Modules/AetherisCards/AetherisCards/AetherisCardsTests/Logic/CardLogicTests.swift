import AetherisDesignSystem
import AetherisCardsInterface
import Core
import Foundation
import Testing
@testable import AetherisCards

@Suite("CardLogic")
struct CardLogicTests {
    @Test
    func chunked_splitsStringIntoFixedSizeGroups() {
        #expect("123456789".chunked(into: 4) == ["1234", "5678", "9"])
        #expect("1234".chunked(into: 2) == ["12", "34"])
    }

    @Test
    func chunked_returnsWholeString_whenSizeIsNotPositive() {
        #expect("123456".chunked(into: 0) == ["123456"])
        #expect("123456".chunked(into: -2) == ["123456"])
    }

    @Test
    func cardServiceErrorMessage_prefersBackendMessage_whenAvailable() {
        let error = CoreServiceError.badRequest(
            .init(
                statusCode: 400,
                message: "The card is locked"
            )
        )

        #expect(
            CardServiceErrorMessage.message(
                for: error,
                fallback: "Fallback"
            ) == "The card is locked"
        )
    }

    @Test
    func cardServiceErrorMessage_usesFallback_whenBackendMessageIsMissing() {
        #expect(
            CardServiceErrorMessage.message(
                for: URLError(.timedOut),
                fallback: "Fallback"
            ) == "Fallback"
        )
    }

    @Test
    @MainActor
    func tabBarRoutingStore_tracksPendingSelectionAndCardsTabTransition() {
        let selectedCardId = UUID(uuidString: "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA")!
        let sut = TabBarRoutingStore()

        #expect(sut.selectedIndex == 0)
        #expect(sut.pendingCardsSelectedCardId == nil)

        sut.showCards(selectedCardId: selectedCardId)

        #expect(sut.selectedIndex == 1)
        #expect(sut.pendingCardsSelectedCardId == selectedCardId)

        sut.clearPendingCardsSelection()

        #expect(sut.pendingCardsSelectedCardId == nil)
        #expect(sut.selectedIndex == 1)
    }

    @Test
    func cardLockModel_masksNumber_andUpdatesStatusWithoutChangingOtherFields() {
        let card = CardLockModel(
            id: UUID(uuidString: "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA")!,
            holderName: "Blake Lehmann",
            lastFourDigits: "4421",
            expirationDate: "09/29",
            brand: .visa,
            style: .gold,
            isBlocked: false
        )

        let updated = card.updating(isBlocked: true)

        #expect(card.maskedNumber == "•••• •••• •••• 4421")
        #expect(updated.id == card.id)
        #expect(updated.holderName == card.holderName)
        #expect(updated.lastFourDigits == card.lastFourDigits)
        #expect(updated.expirationDate == card.expirationDate)
        #expect(updated.brand == card.brand)
        #expect(updated.style == card.style)
        #expect(updated.isBlocked)
    }

    @Test
    func cardOptions_exposeExpectedQuickActionPayloads() {
        let send = CardOptions.send()
        let request = CardOptions.request()
        let virtualCard = CardOptions.virtualCard()
        let blockedAction = CardOptions.cardLock(isBlocked: true)
        let unblockedAction = CardOptions.cardLock(isBlocked: false)

        #expect(send.id == CardOptions.sendId)
        #expect(send.label == Strings.QuickActions.sendTitle)
        #expect(request.id == CardOptions.requestId)
        #expect(request.label == Strings.QuickActions.requestTitle)
        #expect(virtualCard.id == CardOptions.virtualCardId)
        #expect(virtualCard.label == Strings.CardInformation.virtualCardQuickAction)
        #expect(virtualCard.icon == "creditcard")
        #expect(blockedAction.id == CardOptions.cardLockId)
        #expect(blockedAction.label == Strings.CardInformation.unlock)
        #expect(blockedAction.icon == "lock.open")
        #expect(unblockedAction.label == Strings.CardInformation.lock)
        #expect(unblockedAction.icon == "lock")
    }

    @Test
    func currentInvoiceFormatters_formatCurrencyAndDate() {
        let value = Decimal(-123.45)
        let date = makeDate(year: 2026, month: 8, day: 18)

        #expect(value.invoiceCurrencyFormatted.hasPrefix("-"))
        #expect(value.invoiceCurrencyFormatted.contains("123"))
        #expect(date.invoiceDateFormatted.contains("AGO"))
        #expect(date.invoiceDateFormatted.contains("2026"))
    }

    @Test
    func currentInvoiceModel_computesProgressAndEligibility() {
        let dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        let bestPurchaseDate = Calendar.current.date(byAdding: .day, value: 8, to: Date()) ?? Date()
        let invoice = CurrentInvoiceModel(
            id: UUID(uuidString: "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA")!,
            cardId: CardMockIDs.standard,
            amount: 350,
            status: .open,
            dueDate: dueDate,
            bestPurchaseDate: bestPurchaseDate,
            totalLimit: 5_000,
            availableLimit: 2_750,
            usedLimit: 2_250,
            details: .init(
                purchasesSubtotal: 318.50,
                otherCharges: 31.50,
                discountsAndCredits: 0,
                total: 350
            ),
            spendingSummary: .init(
                totalSpent: 2_250,
                installmentPurchases: 1_200,
                oneTimePurchases: 1_050
            )
        )

        let zeroLimitInvoice = CurrentInvoiceModel(
            id: UUID(uuidString: "BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB")!,
            cardId: CardMockIDs.gold,
            amount: 0,
            status: .paid,
            dueDate: makeDate(year: 2026, month: 8, day: 17),
            bestPurchaseDate: bestPurchaseDate,
            totalLimit: 0,
            availableLimit: 0,
            usedLimit: 0,
            details: .init(
                purchasesSubtotal: 0,
                otherCharges: 0,
                discountsAndCredits: 0,
                total: 0
            ),
            spendingSummary: .init(
                totalSpent: 0,
                installmentPurchases: 0,
                oneTimePurchases: 0
            )
        )

        #expect(abs(invoice.usedLimitProgress - 0.45) < 0.0001)
        #expect(invoice.usedLimitPercentage == 45)
        #expect(invoice.daysUntilDueDate == 1)
        #expect(invoice.canBePaid)

        #expect(zeroLimitInvoice.usedLimitProgress == 0)
        #expect(zeroLimitInvoice.usedLimitPercentage == 0)
        #expect(zeroLimitInvoice.daysUntilDueDate == 0)
        #expect(!zeroLimitInvoice.canBePaid)
    }

    @Test(arguments: [
        (InvoiceStatus.open, Strings.CurrentInvoice.Status.open),
        (InvoiceStatus.closed, Strings.CurrentInvoice.Status.closed),
        (InvoiceStatus.overdue, Strings.CurrentInvoice.Status.overdue),
        (InvoiceStatus.paid, Strings.CurrentInvoice.Status.paid)
    ])
    func invoiceStatus_exposesExpectedPresentation(
        status: InvoiceStatus,
        expectedTitle: String
    ) {
        #expect(status.title == expectedTitle)
        _ = status.color
    }

    @Test
    func invoiceSpendingSummary_handlesZeroAndPopulatedTotals() {
        let zero = InvoiceSpendingSummaryModel(
            totalSpent: 0,
            installmentPurchases: 0,
            oneTimePurchases: 0
        )
        let populated = InvoiceSpendingSummaryModel(
            totalSpent: 100,
            installmentPurchases: 25,
            oneTimePurchases: 75
        )

        #expect(zero.installmentProgress == 0)
        #expect(zero.oneTimeProgress == 0)
        #expect(abs(populated.installmentProgress - 0.25) < 0.0001)
        #expect(abs(populated.oneTimeProgress - 0.75) < 0.0001)
    }

    @Test
    func cardHomeFormatters_formatCurrencyAndDate() {
        let value = Decimal(987.65)
        let date = makeDate(year: 2026, month: 8, day: 18)

        #expect(value.currencyFormatted.contains("987"))
        #expect(value.currencyFormatted.contains("R$"))
        #expect(date.dueDateFormatted.contains("18"))
        #expect(date.dueDateFormatted.contains("2026"))
    }

    @Test
    func transactionDetailsFormatters_formatCurrencyAndDate() {
        let value = Decimal(-20.5)
        let date = makeDate(year: 2026, month: 8, day: 18)
        let formattedValue = value.absoluteCurrencyFormatted(code: "USD")

        #expect(formattedValue.contains("20"))
        #expect(formattedValue.contains("50"))
        #expect(formattedValue.contains("$"))
        #expect(date.transactionDateFormatted.contains("18"))
        #expect(date.transactionDateFormatted.contains("2026"))
        #expect(date.shortTransactionDateFormatted.contains("18"))
        #expect(date.shortTransactionDateFormatted.contains("2026"))
    }

    @Test
    func virtualCardModel_formatsNumberAndComputesUsage() {
        let card = VirtualCardModel(
            id: UUID(uuidString: "CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC")!,
            physicalCardId: CardMockIDs.gold,
            holderName: "Blake Lehmann",
            cardNumber: "5329123412347373",
            expirationDate: "09/29",
            securityCode: "123",
            brand: .mastercard,
            style: .gold,
            availableLimit: 6_500,
            totalLimit: 8_000,
            monthlyExpenses: 1_500,
            isActive: true
        )
        let zeroLimitCard = VirtualCardModel(
            id: UUID(uuidString: "DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD")!,
            physicalCardId: CardMockIDs.standard,
            holderName: "Blake Lehmann",
            cardNumber: "4111111111111111",
            expirationDate: "09/29",
            securityCode: "321",
            brand: .visa,
            style: .standard,
            availableLimit: 0,
            totalLimit: 0,
            monthlyExpenses: 0,
            isActive: false
        )

        #expect(card.lastFourDigits == "7373")
        #expect(card.maskedNumber == "•••• •••• •••• 7373")
        #expect(card.formattedNumber == "5329 1234 1234 7373")
        #expect(card.usedLimitProgress == 0.1875)
        #expect(card.monthlyUsagePercentage == 19)

        #expect(zeroLimitCard.usedLimitProgress == 0)
        #expect(zeroLimitCard.monthlyUsagePercentage == 0)
    }

    @Test(arguments: [
        (TransactionType.income, "Income", "arrow.down"),
        (TransactionType.expense, "Expense", "arrow.up"),
        (TransactionType.transfer, "Transfer", "arrow.up.right")
    ])
    func transactionType_exposesExpectedPresentation(
        type: TransactionType,
        expectedTitle: String,
        expectedIcon: String
    ) {
        #expect(type.title == expectedTitle)
        #expect(type.icon == expectedIcon)
        _ = type.color
    }

    @Test(arguments: [
        (0, Strings.Notifications.sectionToday),
        (-1, Strings.Notifications.sectionYesterday),
        (-3, Strings.Notifications.sectionLastWeek),
        (-20, Strings.Notifications.sectionLastMonth),
        (-60, Strings.Notifications.sectionOthers)
    ])
    func financialSummaryModel_sectionClassifiesDate(
        dayOffset: Int,
        expectedSection: String
    ) {
        let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
        let summary = FinancialSummaryModel(
            cardId: CardMockIDs.standard,
            image: "avatar",
            title: "Title",
            description: "Description",
            value: "$ 10.00",
            tag: .expense,
            date: date
        )

        #expect(summary.section == expectedSection)
    }

    @Test
    func cardActivityPreviewData_returnsStandardFallbackForUnknownCardIdentifier() {
        let transactions = CardActivityPreviewData.transactions(for: UUID())

        #expect(transactions.count == 5)
        #expect(transactions.allSatisfy { $0.cardId == CardMockIDs.standard })
    }

    @Test(arguments: [
        (TransactionKind.incomingPayment, true, Strings.TransactionDetails.income, "arrow.down"),
        (TransactionKind.outgoingTransfer, false, Strings.TransactionDetails.transfer, "arrow.up.right"),
        (TransactionKind.purchase, false, Strings.TransactionDetails.purchase, "bag"),
        (TransactionKind.subscription, false, Strings.TransactionDetails.subscription, "arrow.triangle.2.circlepath"),
        (TransactionKind.refund, true, Strings.TransactionDetails.refund, "arrow.uturn.backward"),
        (TransactionKind.invoicePayment, false, Strings.TransactionDetails.invoicePayment, "doc.text")
    ])
    func transactionDetailsModel_mapsKindToPresentation(
        kind: TransactionKind,
        isIncome: Bool,
        expectedTitle: String,
        expectedIcon: String
    ) {
        let transaction = makeTransaction(kind: kind)

        #expect(transaction.isIncome == isIncome)
        #expect(transaction.categoryTitle == expectedTitle)
        #expect(transaction.categoryIcon == expectedIcon)
        #expect(transaction.formattedAmount.hasPrefix(isIncome ? "+" : "-"))
        #expect(transaction.formattedAmount.contains("10"))
        #expect(transaction.formattedAmount.contains("$"))
    }

    @Test(arguments: [
        (TransactionStatus.pending, Strings.TransactionDetails.pending, "clock"),
        (TransactionStatus.processing, Strings.TransactionDetails.processing, "arrow.triangle.2.circlepath"),
        (TransactionStatus.completed, Strings.TransactionDetails.completed, "checkmark.circle.fill"),
        (TransactionStatus.declined, Strings.TransactionDetails.declined, "xmark.circle.fill"),
        (TransactionStatus.cancelled, Strings.TransactionDetails.cancelled, "minus.circle.fill"),
        (TransactionStatus.refunded, Strings.TransactionDetails.refundedStatus, "arrow.uturn.backward.circle.fill")
    ])
    func transactionStatus_exposesExpectedPresentation(
        status: TransactionStatus,
        expectedTitle: String,
        expectedIcon: String
    ) {
        #expect(status.title == expectedTitle)
        #expect(status.icon == expectedIcon)
    }

    @Test(arguments: [
        (TransactionAction.share, Strings.TransactionDetails.share, "square.and.arrow.up"),
        (TransactionAction.download, Strings.TransactionDetails.download, "arrow.down.to.line"),
        (TransactionAction.addNote, Strings.TransactionDetails.addNote, "square.and.pencil"),
        (TransactionAction.reportIssue, Strings.TransactionDetails.reportIssue, "flag")
    ])
    func transactionAction_exposesExpectedPresentation(
        action: TransactionAction,
        expectedTitle: String,
        expectedIcon: String
    ) {
        #expect(action.id == action.rawValue)
        #expect(action.title == expectedTitle)
        #expect(action.icon == expectedIcon)
    }

    @Test(arguments: [
        (BillingFrequency.weekly, Strings.TransactionDetails.weekly),
        (BillingFrequency.monthly, Strings.TransactionDetails.monthly),
        (BillingFrequency.quarterly, Strings.TransactionDetails.quarterly),
        (BillingFrequency.yearly, Strings.TransactionDetails.yearly),
        (BillingFrequency.unknown, Strings.TransactionDetails.notIdentified)
    ])
    func billingFrequency_exposesExpectedTitle(
        frequency: BillingFrequency,
        expectedTitle: String
    ) {
        #expect(frequency.title == expectedTitle)
    }

    private func makeTransaction(kind: TransactionKind) -> TransactionDetailsModel {
        TransactionDetailsModel(
            id: UUID(uuidString: "BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB")!,
            title: "Netflix",
            subtitle: "NETFLIX.COM",
            amount: 10,
            currencyCode: "USD",
            kind: kind,
            status: .completed,
            date: makeDate(year: 2026, month: 8, day: 18),
            transactionCode: "TXN-84K2-19X8-7P3A",
            note: nil,
            imageName: nil,
            imageURL: nil,
            incomingPaymentDetails: nil,
            transferDetails: nil,
            merchantDetails: nil,
            subscriptionDetails: nil,
            refundDetails: nil,
            invoicePaymentDetails: nil,
            availableActions: []
        )
    }

    private func makeDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.calendar = Calendar(identifier: .gregorian)
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return components.date ?? Date(timeIntervalSince1970: 0)
    }
}
