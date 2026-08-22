// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum CardHome {
    /// Cards
    internal static let title = Strings.tr("Localizable", "CardHome.title", fallback: "Cards")
  }
  internal enum CardInformation {
    /// Available limit
    internal static let availableLimit = Strings.tr("Localizable", "CardInformation.availableLimit", fallback: "Available limit")
    /// Closed
    internal static let closedInvoice = Strings.tr("Localizable", "CardInformation.closedInvoice", fallback: "Closed")
    /// Current invoice
    internal static let currentInvoice = Strings.tr("Localizable", "CardInformation.currentInvoice", fallback: "Current invoice")
    /// Due date
    internal static let dueDate = Strings.tr("Localizable", "CardInformation.dueDate", fallback: "Due date")
    /// Due soon
    internal static let dueSoon = Strings.tr("Localizable", "CardInformation.dueSoon", fallback: "Due soon")
    /// Lock
    internal static let lock = Strings.tr("Localizable", "CardInformation.lock", fallback: "Lock")
    /// Open
    internal static let openInvoice = Strings.tr("Localizable", "CardInformation.openInvoice", fallback: "Open")
    /// of %@
    internal static func totalLimit(_ p1: Any) -> String {
      return Strings.tr("Localizable", "CardInformation.totalLimit", String(describing: p1), fallback: "of %@")
    }
    /// Unlock
    internal static let unlock = Strings.tr("Localizable", "CardInformation.unlock", fallback: "Unlock")
    /// Virtual card
    internal static let virtualCard = Strings.tr("Localizable", "CardInformation.virtualCard", fallback: "Virtual card")
    /// Virtual
    /// card
    internal static let virtualCardQuickAction = Strings.tr("Localizable", "CardInformation.virtualCardQuickAction", fallback: "Virtual\ncard")
  }
  internal enum CardLock {
    /// LOCKED
    internal static let blocked = Strings.tr("Localizable", "CardLock.blocked", fallback: "LOCKED")
    /// Your card is locked. Unlock it when you are ready to use it again.
    internal static let blockedDescription = Strings.tr("Localizable", "CardLock.blockedDescription", fallback: "Your card is locked. Unlock it when you are ready to use it again.")
    /// While locked, new purchases and withdrawals are not allowed.
    internal static let blockedStatusDescription = Strings.tr("Localizable", "CardLock.blockedStatusDescription", fallback: "While locked, new purchases and withdrawals are not allowed.")
    /// Your card is locked
    internal static let cardIsBlocked = Strings.tr("Localizable", "CardLock.cardIsBlocked", fallback: "Your card is locked")
    /// Your card is unlocked
    internal static let cardIsUnlocked = Strings.tr("Localizable", "CardLock.cardIsUnlocked", fallback: "Your card is unlocked")
    /// Card settings
    internal static let cardSettings = Strings.tr("Localizable", "CardLock.cardSettings", fallback: "Card settings")
    /// Limits, international usage, and other preferences
    internal static let cardSettingsDescription = Strings.tr("Localizable", "CardLock.cardSettingsDescription", fallback: "Limits, international usage, and other preferences")
    /// Digital wallets and contactless payments will not work.
    internal static let contactlessDisabledDescription = Strings.tr("Localizable", "CardLock.contactlessDisabledDescription", fallback: "Digital wallets and contactless payments will not work.")
    /// Contactless payments are disabled
    internal static let contactlessDisabledTitle = Strings.tr("Localizable", "CardLock.contactlessDisabledTitle", fallback: "Contactless payments are disabled")
    /// We could not find the data needed to manage this card.
    internal static let emptyDescription = Strings.tr("Localizable", "CardLock.emptyDescription", fallback: "We could not find the data needed to manage this card.")
    /// Card not found
    internal static let emptyTitle = Strings.tr("Localizable", "CardLock.emptyTitle", fallback: "Card not found")
    /// Lock card
    internal static let lockCard = Strings.tr("Localizable", "CardLock.lockCard", fallback: "Lock card")
    /// New purchases, withdrawals, and payments will be declined until you unlock the card.
    internal static let lockConfirmationDescription = Strings.tr("Localizable", "CardLock.lockConfirmationDescription", fallback: "New purchases, withdrawals, and payments will be declined until you unlock the card.")
    /// Lock this card?
    internal static let lockConfirmationTitle = Strings.tr("Localizable", "CardLock.lockConfirmationTitle", fallback: "Lock this card?")
    /// Lock card
    internal static let lockTitle = Strings.tr("Localizable", "CardLock.lockTitle", fallback: "Lock card")
    /// Locking the card does not affect your account balance or current invoice.
    internal static let moneyIsSafeDescription = Strings.tr("Localizable", "CardLock.moneyIsSafeDescription", fallback: "Locking the card does not affect your account balance or current invoice.")
    /// Your money is safe
    internal static let moneyIsSafeTitle = Strings.tr("Localizable", "CardLock.moneyIsSafeTitle", fallback: "Your money is safe")
    /// Other options
    internal static let otherOptions = Strings.tr("Localizable", "CardLock.otherOptions", fallback: "Other options")
    /// You will not be able to make in-person or online purchases.
    internal static let purchasesRefusedDescription = Strings.tr("Localizable", "CardLock.purchasesRefusedDescription", fallback: "You will not be able to make in-person or online purchases.")
    /// New purchases are declined
    internal static let purchasesRefusedTitle = Strings.tr("Localizable", "CardLock.purchasesRefusedTitle", fallback: "New purchases are declined")
    /// Request new card
    internal static let requestNewCard = Strings.tr("Localizable", "CardLock.requestNewCard", fallback: "Request new card")
    /// In case of loss, theft, or damage
    internal static let requestNewCardDescription = Strings.tr("Localizable", "CardLock.requestNewCardDescription", fallback: "In case of loss, theft, or damage")
    /// Recurring services linked to this card may be interrupted.
    internal static let subscriptionsAffectedDescription = Strings.tr("Localizable", "CardLock.subscriptionsAffectedDescription", fallback: "Recurring services linked to this card may be interrupted.")
    /// Subscriptions may be affected
    internal static let subscriptionsAffectedTitle = Strings.tr("Localizable", "CardLock.subscriptionsAffectedTitle", fallback: "Subscriptions may be affected")
    /// Card status
    internal static let title = Strings.tr("Localizable", "CardLock.title", fallback: "Card status")
    /// We could not load this card
    internal static let unavailableTitle = Strings.tr("Localizable", "CardLock.unavailableTitle", fallback: "We could not load this card")
    /// UNLOCKED
    internal static let unblocked = Strings.tr("Localizable", "CardLock.unblocked", fallback: "UNLOCKED")
    /// Manage your physical card status securely and with full control.
    internal static let unblockedDescription = Strings.tr("Localizable", "CardLock.unblockedDescription", fallback: "Manage your physical card status securely and with full control.")
    /// Your card is active and ready for purchases, withdrawals, and payments.
    internal static let unblockedStatusDescription = Strings.tr("Localizable", "CardLock.unblockedStatusDescription", fallback: "Your card is active and ready for purchases, withdrawals, and payments.")
    /// Unlock card
    internal static let unlockCard = Strings.tr("Localizable", "CardLock.unlockCard", fallback: "Unlock card")
    /// The card will work again for purchases, withdrawals, and payments.
    internal static let unlockConfirmationDescription = Strings.tr("Localizable", "CardLock.unlockConfirmationDescription", fallback: "The card will work again for purchases, withdrawals, and payments.")
    /// Unlock this card?
    internal static let unlockConfirmationTitle = Strings.tr("Localizable", "CardLock.unlockConfirmationTitle", fallback: "Unlock this card?")
    /// Unlock card
    internal static let unlockTitle = Strings.tr("Localizable", "CardLock.unlockTitle", fallback: "Unlock card")
    /// Valid until
    internal static let validUntil = Strings.tr("Localizable", "CardLock.validUntil", fallback: "Valid until")
    /// Virtual card
    internal static let virtualCard = Strings.tr("Localizable", "CardLock.virtualCard", fallback: "Virtual card")
    /// Manage your virtual card
    internal static let virtualCardDescription = Strings.tr("Localizable", "CardLock.virtualCardDescription", fallback: "Manage your virtual card")
    /// What happens when you lock it
    internal static let whenBlockingTitle = Strings.tr("Localizable", "CardLock.whenBlockingTitle", fallback: "What happens when you lock it")
    /// While your card is locked
    internal static let whileBlockedTitle = Strings.tr("Localizable", "CardLock.whileBlockedTitle", fallback: "While your card is locked")
    /// Cash withdrawals will not be allowed.
    internal static let withdrawalsDisabledDescription = Strings.tr("Localizable", "CardLock.withdrawalsDisabledDescription", fallback: "Cash withdrawals will not be allowed.")
    /// Withdrawals are disabled
    internal static let withdrawalsDisabledTitle = Strings.tr("Localizable", "CardLock.withdrawalsDisabledTitle", fallback: "Withdrawals are disabled")
  }
  internal enum Common {
    /// Back
    internal static let back = Strings.tr("Localizable", "Common.back", fallback: "Back")
    /// Cancel
    internal static let cancel = Strings.tr("Localizable", "Common.cancel", fallback: "Cancel")
    /// OK
    internal static let ok = Strings.tr("Localizable", "Common.ok", fallback: "OK")
    /// See all
    internal static let seeAll = Strings.tr("Localizable", "Common.seeAll", fallback: "See all")
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again")
  }
  internal enum CurrentInvoice {
    /// Available limit
    internal static let availableLimit = Strings.tr("Localizable", "CurrentInvoice.availableLimit", fallback: "Available limit")
    /// Best purchase date
    internal static let bestPurchaseDate = Strings.tr("Localizable", "CurrentInvoice.bestPurchaseDate", fallback: "Best purchase date")
    /// Close notice
    internal static let closeNotice = Strings.tr("Localizable", "CurrentInvoice.closeNotice", fallback: "Close notice")
    /// %d days until due
    internal static func daysUntilDue(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.daysUntilDue", p1, fallback: "%d days until due")
    }
    /// Track your invoice amount, due date, and spending details for this period.
    internal static let description = Strings.tr("Localizable", "CurrentInvoice.description", fallback: "Track your invoice amount, due date, and spending details for this period.")
    /// Invoice details
    internal static let detailsTitle = Strings.tr("Localizable", "CurrentInvoice.detailsTitle", fallback: "Invoice details")
    /// Discounts and credits
    internal static let discountsAndCredits = Strings.tr("Localizable", "CurrentInvoice.discountsAndCredits", fallback: "Discounts and credits")
    /// Payments and refunds
    internal static let discountsAndCreditsDescription = Strings.tr("Localizable", "CurrentInvoice.discountsAndCreditsDescription", fallback: "Payments and refunds")
    /// Due date
    internal static let dueDate = Strings.tr("Localizable", "CurrentInvoice.dueDate", fallback: "Due date")
    /// Due today
    internal static let dueToday = Strings.tr("Localizable", "CurrentInvoice.dueToday", fallback: "Due today")
    /// When you make purchases with your card, transactions will appear here.
    internal static let emptyDescription = Strings.tr("Localizable", "CurrentInvoice.emptyDescription", fallback: "When you make purchases with your card, transactions will appear here.")
    /// No invoice available
    internal static let emptyTitle = Strings.tr("Localizable", "CurrentInvoice.emptyTitle", fallback: "No invoice available")
    /// Installments
    internal static let installment = Strings.tr("Localizable", "CurrentInvoice.installment", fallback: "Installments")
    /// %d percent installments
    internal static func installmentAccessibilityValue(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.installmentAccessibilityValue", p1, fallback: "%d percent installments")
    }
    /// Invoice total
    internal static let invoiceTotal = Strings.tr("Localizable", "CurrentInvoice.invoiceTotal", fallback: "Invoice total")
    /// Pay by the due date to avoid interest and keep your limit available.
    internal static let noticeDescription = Strings.tr("Localizable", "CurrentInvoice.noticeDescription", fallback: "Pay by the due date to avoid interest and keep your limit available.")
    /// Open invoice
    internal static let noticeTitle = Strings.tr("Localizable", "CurrentInvoice.noticeTitle", fallback: "Open invoice")
    /// 1 day until due
    internal static let oneDayUntilDue = Strings.tr("Localizable", "CurrentInvoice.oneDayUntilDue", fallback: "1 day until due")
    /// One-time
    internal static let oneTime = Strings.tr("Localizable", "CurrentInvoice.oneTime", fallback: "One-time")
    /// Other charges
    internal static let otherCharges = Strings.tr("Localizable", "CurrentInvoice.otherCharges", fallback: "Other charges")
    /// Fees, charges, and adjustments
    internal static let otherChargesDescription = Strings.tr("Localizable", "CurrentInvoice.otherChargesDescription", fallback: "Fees, charges, and adjustments")
    /// Payment overdue
    internal static let overduePayment = Strings.tr("Localizable", "CurrentInvoice.overduePayment", fallback: "Payment overdue")
    /// Invoice paid
    internal static let paidInvoice = Strings.tr("Localizable", "CurrentInvoice.paidInvoice", fallback: "Invoice paid")
    /// Pay invoice
    internal static let payInvoice = Strings.tr("Localizable", "CurrentInvoice.payInvoice", fallback: "Pay invoice")
    /// Purchases subtotal
    internal static let purchasesSubtotal = Strings.tr("Localizable", "CurrentInvoice.purchasesSubtotal", fallback: "Purchases subtotal")
    /// Domestic and international purchases
    internal static let purchasesSubtotalDescription = Strings.tr("Localizable", "CurrentInvoice.purchasesSubtotalDescription", fallback: "Domestic and international purchases")
    /// See charts
    internal static let seeCharts = Strings.tr("Localizable", "CurrentInvoice.seeCharts", fallback: "See charts")
    /// Spending distribution
    internal static let spendingDistribution = Strings.tr("Localizable", "CurrentInvoice.spendingDistribution", fallback: "Spending distribution")
    /// Spending summary
    internal static let spendingSummaryTitle = Strings.tr("Localizable", "CurrentInvoice.spendingSummaryTitle", fallback: "Spending summary")
    /// Current invoice
    internal static let title = Strings.tr("Localizable", "CurrentInvoice.title", fallback: "Current invoice")
    /// Total invoice amount
    internal static let totalAmount = Strings.tr("Localizable", "CurrentInvoice.totalAmount", fallback: "Total invoice amount")
    /// Total limit
    internal static let totalLimit = Strings.tr("Localizable", "CurrentInvoice.totalLimit", fallback: "Total limit")
    /// Total spent this period
    internal static let totalSpent = Strings.tr("Localizable", "CurrentInvoice.totalSpent", fallback: "Total spent this period")
    /// We could not load your invoice
    internal static let unavailableTitle = Strings.tr("Localizable", "CurrentInvoice.unavailableTitle", fallback: "We could not load your invoice")
    /// Used limit
    internal static let usedLimit = Strings.tr("Localizable", "CurrentInvoice.usedLimit", fallback: "Used limit")
    /// %d%% of limit
    internal static func usedLimitPercentage(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.usedLimitPercentage", p1, fallback: "%d%% of limit")
    }
    internal enum Status {
      /// Closed
      internal static let closed = Strings.tr("Localizable", "CurrentInvoice.Status.closed", fallback: "Closed")
      /// Open
      internal static let `open` = Strings.tr("Localizable", "CurrentInvoice.Status.open", fallback: "Open")
      /// Overdue
      internal static let overdue = Strings.tr("Localizable", "CurrentInvoice.Status.overdue", fallback: "Overdue")
      /// Paid
      internal static let paid = Strings.tr("Localizable", "CurrentInvoice.Status.paid", fallback: "Paid")
    }
  }
  internal enum FinancialSummary {
    /// Apple.Com/Bill
    internal static let appleBill = Strings.tr("Localizable", "FinancialSummary.appleBill", fallback: "Apple.Com/Bill")
    /// %d days ago
    internal static func daysAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.daysAgo", p1, fallback: "%d days ago")
    }
    /// Ifd* Joe's Bar
    internal static let ifoodBar = Strings.tr("Localizable", "FinancialSummary.ifoodBar", fallback: "Ifd* Joe's Bar")
    /// %d month ago
    internal static func monthAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.monthAgo", p1, fallback: "%d month ago")
    }
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "FinancialSummary.netflix", fallback: "Netflix")
    /// Payment received
    internal static let paymentReceived = Strings.tr("Localizable", "FinancialSummary.paymentReceived", fallback: "Payment received")
    /// Funds received from Amelia Thompson
    internal static let paymentReceivedDescription = Strings.tr("Localizable", "FinancialSummary.paymentReceivedDescription", fallback: "Funds received from Amelia Thompson")
    /// Restaurant
    internal static let restaurant = Strings.tr("Localizable", "FinancialSummary.restaurant", fallback: "Restaurant")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "FinancialSummary.subscription", fallback: "Subscription")
    /// Transfer sent
    internal static let transferSent = Strings.tr("Localizable", "FinancialSummary.transferSent", fallback: "Transfer sent")
    /// Funds successfully transferred to Amelia Thompson
    internal static let transferSentAmeliaDescription = Strings.tr("Localizable", "FinancialSummary.transferSentAmeliaDescription", fallback: "Funds successfully transferred to Amelia Thompson")
    /// Funds successfully transferred to Sophie Keller
    internal static let transferSentDescription = Strings.tr("Localizable", "FinancialSummary.transferSentDescription", fallback: "Funds successfully transferred to Sophie Keller")
  }
  internal enum HomeCard {
    /// Cards unavailable
    internal static let cardsUnavailableTitle = Strings.tr("Localizable", "HomeCard.cardsUnavailableTitle", fallback: "Cards unavailable")
    /// This area will reflect the dashboard when the simulated service returns data.
    internal static let emptyDescription = Strings.tr("Localizable", "HomeCard.emptyDescription", fallback: "This area will reflect the dashboard when the simulated service returns data.")
    /// No cards or activity yet
    internal static let emptyTitle = Strings.tr("Localizable", "HomeCard.emptyTitle", fallback: "No cards or activity yet")
    /// We could not load your cards and activity right now.
    internal static let loadFailed = Strings.tr("Localizable", "HomeCard.loadFailed", fallback: "We could not load your cards and activity right now.")
  }
  internal enum Mock {
    /// Account balance
    internal static let accountBalance = Strings.tr("Localizable", "Mock.accountBalance", fallback: "Account balance")
    /// Aetheris account
    internal static let aetherisAccount = Strings.tr("Localizable", "Mock.aetherisAccount", fallback: "Aetheris account")
    /// Aetheris checking
    internal static let aetherisChecking = Strings.tr("Localizable", "Mock.aetherisChecking", fallback: "Aetheris checking")
    /// August 2026
    internal static let august2026 = Strings.tr("Localizable", "Mock.august2026", fallback: "August 2026")
    /// Bank transfer
    internal static let bankTransfer = Strings.tr("Localizable", "Mock.bankTransfer", fallback: "Bank transfer")
    /// Dinner split
    internal static let dinnerSplit = Strings.tr("Localizable", "Mock.dinnerSplit", fallback: "Dinner split")
    /// Entertainment
    internal static let entertainment = Strings.tr("Localizable", "Mock.entertainment", fallback: "Entertainment")
    /// Instant payment
    internal static let instantPayment = Strings.tr("Localizable", "Mock.instantPayment", fallback: "Instant payment")
    /// Instant transfer
    internal static let instantTransfer = Strings.tr("Localizable", "Mock.instantTransfer", fallback: "Instant transfer")
    /// Invoice payment
    internal static let invoicePayment = Strings.tr("Localizable", "Mock.invoicePayment", fallback: "Invoice payment")
    /// Loading
    internal static let loading = Strings.tr("Localizable", "Mock.loading", fallback: "Loading")
    /// Merchant refund
    internal static let merchantRefund = Strings.tr("Localizable", "Mock.merchantRefund", fallback: "Merchant refund")
    /// Original purchase refunded
    internal static let originalPurchaseRefunded = Strings.tr("Localizable", "Mock.originalPurchaseRefunded", fallback: "Original purchase refunded")
    /// Payment received
    internal static let paymentReceived = Strings.tr("Localizable", "Mock.paymentReceived", fallback: "Payment received")
    /// Personal transfer
    internal static let personalTransfer = Strings.tr("Localizable", "Mock.personalTransfer", fallback: "Personal transfer")
    /// Physical card
    internal static let physicalCard = Strings.tr("Localizable", "Mock.physicalCard", fallback: "Physical card")
    /// Refund
    internal static let refund = Strings.tr("Localizable", "Mock.refund", fallback: "Refund")
    /// Restaurant
    internal static let restaurant = Strings.tr("Localizable", "Mock.restaurant", fallback: "Restaurant")
    /// Sao Paulo, Brazil
    internal static let saoPauloBrazil = Strings.tr("Localizable", "Mock.saoPauloBrazil", fallback: "Sao Paulo, Brazil")
    /// Transaction
    internal static let transaction = Strings.tr("Localizable", "Mock.transaction", fallback: "Transaction")
    /// Unknown merchant
    internal static let unknownMerchant = Strings.tr("Localizable", "Mock.unknownMerchant", fallback: "Unknown merchant")
    /// Virtual card
    internal static let virtualCard = Strings.tr("Localizable", "Mock.virtualCard", fallback: "Virtual card")
  }
  internal enum Notifications {
    /// Last Month
    internal static let sectionLastMonth = Strings.tr("Localizable", "Notifications.sectionLastMonth", fallback: "Last Month")
    /// Last Week
    internal static let sectionLastWeek = Strings.tr("Localizable", "Notifications.sectionLastWeek", fallback: "Last Week")
    /// Others
    internal static let sectionOthers = Strings.tr("Localizable", "Notifications.sectionOthers", fallback: "Others")
    /// Today
    internal static let sectionToday = Strings.tr("Localizable", "Notifications.sectionToday", fallback: "Today")
    /// Yesterday
    internal static let sectionYesterday = Strings.tr("Localizable", "Notifications.sectionYesterday", fallback: "Yesterday")
  }
  internal enum QuickActions {
    /// All services
    internal static let moreSubtitle = Strings.tr("Localizable", "QuickActions.moreSubtitle", fallback: "All services")
    /// More
    internal static let moreTitle = Strings.tr("Localizable", "QuickActions.moreTitle", fallback: "More")
    /// Pay bills
    internal static let paySubtitle = Strings.tr("Localizable", "QuickActions.paySubtitle", fallback: "Pay bills")
    /// Pay
    internal static let payTitle = Strings.tr("Localizable", "QuickActions.payTitle", fallback: "Pay")
    /// Receive money
    internal static let requestSubtitle = Strings.tr("Localizable", "QuickActions.requestSubtitle", fallback: "Receive money")
    /// Request
    internal static let requestTitle = Strings.tr("Localizable", "QuickActions.requestTitle", fallback: "Request")
    /// What would you like to do ?
    internal static let sectionTitle = Strings.tr("Localizable", "QuickActions.sectionTitle", fallback: "What would you like to do ?")
    /// Send
    internal static let sendTitle = Strings.tr("Localizable", "QuickActions.sendTitle", fallback: "Send")
    /// Add funds
    internal static let topUpSubtitle = Strings.tr("Localizable", "QuickActions.topUpSubtitle", fallback: "Add funds")
    /// Top up
    internal static let topUpTitle = Strings.tr("Localizable", "QuickActions.topUpTitle", fallback: "Top up")
    /// Send money
    internal static let transferSubtitle = Strings.tr("Localizable", "QuickActions.transferSubtitle", fallback: "Send money")
    /// Transfer
    internal static let transferTitle = Strings.tr("Localizable", "QuickActions.transferTitle", fallback: "Transfer")
  }
  internal enum TransactionDetails {
    /// Add note
    internal static let addNote = Strings.tr("Localizable", "TransactionDetails.addNote", fallback: "Add note")
    /// Allow future payments
    internal static let allowFuturePayments = Strings.tr("Localizable", "TransactionDetails.allowFuturePayments", fallback: "Allow future payments")
    /// Future charges from this merchant will be allowed again.
    internal static let allowFuturePaymentsDescription = Strings.tr("Localizable", "TransactionDetails.allowFuturePaymentsDescription", fallback: "Future charges from this merchant will be allowed again.")
    /// Amount
    internal static let amount = Strings.tr("Localizable", "TransactionDetails.amount", fallback: "Amount")
    /// Billing frequency
    internal static let billingFrequency = Strings.tr("Localizable", "TransactionDetails.billingFrequency", fallback: "Billing frequency")
    /// Block future payments
    internal static let blockFuturePayments = Strings.tr("Localizable", "TransactionDetails.blockFuturePayments", fallback: "Block future payments")
    /// Future charges from this merchant will be declined.
    internal static let blockFuturePaymentsDescription = Strings.tr("Localizable", "TransactionDetails.blockFuturePaymentsDescription", fallback: "Future charges from this merchant will be declined.")
    /// Cancelled
    internal static let cancelled = Strings.tr("Localizable", "TransactionDetails.cancelled", fallback: "Cancelled")
    /// Category
    internal static let category = Strings.tr("Localizable", "TransactionDetails.category", fallback: "Category")
    /// Completed
    internal static let completed = Strings.tr("Localizable", "TransactionDetails.completed", fallback: "Completed")
    /// Confirmation code
    internal static let confirmationCode = Strings.tr("Localizable", "TransactionDetails.confirmationCode", fallback: "Confirmation code")
    /// Date
    internal static let date = Strings.tr("Localizable", "TransactionDetails.date", fallback: "Date")
    /// Declined
    internal static let declined = Strings.tr("Localizable", "TransactionDetails.declined", fallback: "Declined")
    /// Download
    internal static let download = Strings.tr("Localizable", "TransactionDetails.download", fallback: "Download")
    /// We couldn't find the details for this transaction.
    internal static let emptyDescription = Strings.tr("Localizable", "TransactionDetails.emptyDescription", fallback: "We couldn't find the details for this transaction.")
    /// Transaction not found
    internal static let emptyTitle = Strings.tr("Localizable", "TransactionDetails.emptyTitle", fallback: "Transaction not found")
    /// Something went wrong
    internal static let errorTitle = Strings.tr("Localizable", "TransactionDetails.errorTitle", fallback: "Something went wrong")
    /// Expected amount
    internal static let expectedAmount = Strings.tr("Localizable", "TransactionDetails.expectedAmount", fallback: "Expected amount")
    /// Expected availability
    internal static let expectedAvailability = Strings.tr("Localizable", "TransactionDetails.expectedAvailability", fallback: "Expected availability")
    /// From
    internal static let from = Strings.tr("Localizable", "TransactionDetails.from", fallback: "From")
    /// Get support
    internal static let getSupport = Strings.tr("Localizable", "TransactionDetails.getSupport", fallback: "Get support")
    /// Income
    internal static let income = Strings.tr("Localizable", "TransactionDetails.income", fallback: "Income")
    /// Institution
    internal static let institution = Strings.tr("Localizable", "TransactionDetails.institution", fallback: "Institution")
    /// Invoice
    internal static let invoice = Strings.tr("Localizable", "TransactionDetails.invoice", fallback: "Invoice")
    /// Invoice payment
    internal static let invoicePayment = Strings.tr("Localizable", "TransactionDetails.invoicePayment", fallback: "Invoice payment")
    /// Invoice payment details
    internal static let invoicePaymentDetails = Strings.tr("Localizable", "TransactionDetails.invoicePaymentDetails", fallback: "Invoice payment details")
    /// Location
    internal static let location = Strings.tr("Localizable", "TransactionDetails.location", fallback: "Location")
    /// Merchant
    internal static let merchant = Strings.tr("Localizable", "TransactionDetails.merchant", fallback: "Merchant")
    /// Method
    internal static let method = Strings.tr("Localizable", "TransactionDetails.method", fallback: "Method")
    /// Monthly
    internal static let monthly = Strings.tr("Localizable", "TransactionDetails.monthly", fallback: "Monthly")
    /// Need help?
    internal static let needHelp = Strings.tr("Localizable", "TransactionDetails.needHelp", fallback: "Need help?")
    /// Next expected payment: %@
    internal static func nextExpectedPayment(_ p1: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.nextExpectedPayment", String(describing: p1), fallback: "Next expected payment: %@")
    }
    /// Next expected payment
    internal static let nextPayment = Strings.tr("Localizable", "TransactionDetails.nextPayment", fallback: "Next expected payment")
    /// Note
    internal static let note = Strings.tr("Localizable", "TransactionDetails.note", fallback: "Note")
    /// Not identified
    internal static let notIdentified = Strings.tr("Localizable", "TransactionDetails.notIdentified", fallback: "Not identified")
    /// Original transaction
    internal static let originalTransaction = Strings.tr("Localizable", "TransactionDetails.originalTransaction", fallback: "Original transaction")
    /// Paid amount
    internal static let paidAmount = Strings.tr("Localizable", "TransactionDetails.paidAmount", fallback: "Paid amount")
    /// Payment details
    internal static let paymentDetails = Strings.tr("Localizable", "TransactionDetails.paymentDetails", fallback: "Payment details")
    /// Payment history
    internal static let paymentHistory = Strings.tr("Localizable", "TransactionDetails.paymentHistory", fallback: "Payment history")
    /// Payment method
    internal static let paymentMethod = Strings.tr("Localizable", "TransactionDetails.paymentMethod", fallback: "Payment method")
    /// Pending
    internal static let pending = Strings.tr("Localizable", "TransactionDetails.pending", fallback: "Pending")
    /// Processing
    internal static let processing = Strings.tr("Localizable", "TransactionDetails.processing", fallback: "Processing")
    /// Purchase
    internal static let purchase = Strings.tr("Localizable", "TransactionDetails.purchase", fallback: "Purchase")
    /// Purchase details
    internal static let purchaseDetails = Strings.tr("Localizable", "TransactionDetails.purchaseDetails", fallback: "Purchase details")
    /// Every three months
    internal static let quarterly = Strings.tr("Localizable", "TransactionDetails.quarterly", fallback: "Every three months")
    /// Reason
    internal static let reason = Strings.tr("Localizable", "TransactionDetails.reason", fallback: "Reason")
    /// %@ usually charges %@ every month.
    internal static func recurringMonthly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringMonthly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every month.")
    }
    /// Recurring payment
    internal static let recurringPayment = Strings.tr("Localizable", "TransactionDetails.recurringPayment", fallback: "Recurring payment")
    /// %@ usually charges %@ every three months.
    internal static func recurringQuarterly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringQuarterly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every three months.")
    }
    /// We identified similar recurring payments from this merchant.
    internal static let recurringUnknown = Strings.tr("Localizable", "TransactionDetails.recurringUnknown", fallback: "We identified similar recurring payments from this merchant.")
    /// %@ usually charges %@ every week.
    internal static func recurringWeekly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringWeekly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every week.")
    }
    /// %@ usually charges %@ every year.
    internal static func recurringYearly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringYearly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every year.")
    }
    /// Reference
    internal static let reference = Strings.tr("Localizable", "TransactionDetails.reference", fallback: "Reference")
    /// Refund
    internal static let refund = Strings.tr("Localizable", "TransactionDetails.refund", fallback: "Refund")
    /// Refund details
    internal static let refundDetails = Strings.tr("Localizable", "TransactionDetails.refundDetails", fallback: "Refund details")
    /// Refunded
    internal static let refundedStatus = Strings.tr("Localizable", "TransactionDetails.refundedStatus", fallback: "Refunded")
    /// Report issue
    internal static let reportIssue = Strings.tr("Localizable", "TransactionDetails.reportIssue", fallback: "Report issue")
    /// Share
    internal static let share = Strings.tr("Localizable", "TransactionDetails.share", fallback: "Share")
    /// Status
    internal static let status = Strings.tr("Localizable", "TransactionDetails.status", fallback: "Status")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "TransactionDetails.subscription", fallback: "Subscription")
    /// Subscription details
    internal static let subscriptionDetails = Strings.tr("Localizable", "TransactionDetails.subscriptionDetails", fallback: "Subscription details")
    /// If you have any questions about this transaction, we're here to help.
    internal static let supportDescription = Strings.tr("Localizable", "TransactionDetails.supportDescription", fallback: "If you have any questions about this transaction, we're here to help.")
    /// Transaction Details
    internal static let title = Strings.tr("Localizable", "TransactionDetails.title", fallback: "Transaction Details")
    /// To
    internal static let to = Strings.tr("Localizable", "TransactionDetails.to", fallback: "To")
    /// Transaction ID
    internal static let transactionId = Strings.tr("Localizable", "TransactionDetails.transactionId", fallback: "Transaction ID")
    /// Transfer
    internal static let transfer = Strings.tr("Localizable", "TransactionDetails.transfer", fallback: "Transfer")
    /// Transfer details
    internal static let transferDetails = Strings.tr("Localizable", "TransactionDetails.transferDetails", fallback: "Transfer details")
    /// Type
    internal static let type = Strings.tr("Localizable", "TransactionDetails.type", fallback: "Type")
    /// Transaction unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "TransactionDetails.unavailableTitle", fallback: "Transaction unavailable")
    /// Weekly
    internal static let weekly = Strings.tr("Localizable", "TransactionDetails.weekly", fallback: "Weekly")
    /// Yearly
    internal static let yearly = Strings.tr("Localizable", "TransactionDetails.yearly", fallback: "Yearly")
  }
  internal enum TransactionHistory {
    /// This account does not have transaction history in the simulated dataset.
    internal static let emptyDescription = Strings.tr("Localizable", "TransactionHistory.emptyDescription", fallback: "This account does not have transaction history in the simulated dataset.")
    /// No transactions yet
    internal static let emptyTitle = Strings.tr("Localizable", "TransactionHistory.emptyTitle", fallback: "No transactions yet")
    /// We could not load your transaction history.
    internal static let loadFailed = Strings.tr("Localizable", "TransactionHistory.loadFailed", fallback: "We could not load your transaction history.")
    /// Transaction History
    internal static let title = Strings.tr("Localizable", "TransactionHistory.title", fallback: "Transaction History")
    /// History unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "TransactionHistory.unavailableTitle", fallback: "History unavailable")
  }
  internal enum TransactionsHistory {
    /// Apple
    internal static let apple = Strings.tr("Localizable", "TransactionsHistory.apple", fallback: "Apple")
    /// Deposit
    internal static let deposit = Strings.tr("Localizable", "TransactionsHistory.deposit", fallback: "Deposit")
    /// Sophie Keller
    internal static let melissa = Strings.tr("Localizable", "TransactionsHistory.melissa", fallback: "Sophie Keller")
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "TransactionsHistory.netflix", fallback: "Netflix")
    /// Payment
    internal static let payment = Strings.tr("Localizable", "TransactionsHistory.payment", fallback: "Payment")
    /// Purchase
    internal static let purchase = Strings.tr("Localizable", "TransactionsHistory.purchase", fallback: "Purchase")
    /// Salary
    internal static let salary = Strings.tr("Localizable", "TransactionsHistory.salary", fallback: "Salary")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "TransactionsHistory.subscription", fallback: "Subscription")
    /// Swarovski
    internal static let swarovski = Strings.tr("Localizable", "TransactionsHistory.swarovski", fallback: "Swarovski")
    /// Transactions History
    internal static let title = Strings.tr("Localizable", "TransactionsHistory.title", fallback: "Transactions History")
    /// Transfer received
    internal static let transferReceived = Strings.tr("Localizable", "TransactionsHistory.transferReceived", fallback: "Transfer received")
  }
  internal enum VirtualCard {
    /// Your card is ready to use
    internal static let activeDescription = Strings.tr("Localizable", "VirtualCard.activeDescription", fallback: "Your card is ready to use")
    /// Virtual card active
    internal static let activeTitle = Strings.tr("Localizable", "VirtualCard.activeTitle", fallback: "Virtual card active")
    /// Available limit
    internal static let availableLimit = Strings.tr("Localizable", "VirtualCard.availableLimit", fallback: "Available limit")
    /// Cancel
    internal static let cancel = Strings.tr("Localizable", "VirtualCard.cancel", fallback: "Cancel")
    /// Card number
    internal static let cardNumberAccessibilityLabel = Strings.tr("Localizable", "VirtualCard.cardNumberAccessibilityLabel", fallback: "Card number")
    /// Virtual
    internal static let cardType = Strings.tr("Localizable", "VirtualCard.cardType", fallback: "Virtual")
    /// Number copied
    internal static let copied = Strings.tr("Localizable", "VirtualCard.copied", fallback: "Number copied")
    /// Copy number
    internal static let copyNumber = Strings.tr("Localizable", "VirtualCard.copyNumber", fallback: "Copy number")
    /// Use your virtual card for online purchases and subscriptions with more security.
    internal static let description = Strings.tr("Localizable", "VirtualCard.description", fallback: "Use your virtual card for online purchases and subscriptions with more security.")
    /// Create a virtual card to make online purchases more securely.
    internal static let emptyDescription = Strings.tr("Localizable", "VirtualCard.emptyDescription", fallback: "Create a virtual card to make online purchases more securely.")
    /// You do not have a virtual card yet
    internal static let emptyTitle = Strings.tr("Localizable", "VirtualCard.emptyTitle", fallback: "You do not have a virtual card yet")
    /// Generate new number
    internal static let generateConfirmationAction = Strings.tr("Localizable", "VirtualCard.generateConfirmationAction", fallback: "Generate new number")
    /// The current number will stop working. Recurring purchases and subscriptions may need to be updated.
    internal static let generateConfirmationMessage = Strings.tr("Localizable", "VirtualCard.generateConfirmationMessage", fallback: "The current number will stop working. Recurring purchases and subscriptions may need to be updated.")
    /// Generate a new number?
    internal static let generateConfirmationTitle = Strings.tr("Localizable", "VirtualCard.generateConfirmationTitle", fallback: "Generate a new number?")
    /// Generate new number
    internal static let generateNewNumber = Strings.tr("Localizable", "VirtualCard.generateNewNumber", fallback: "Generate new number")
    /// Hidden number
    internal static let hiddenNumberAccessibilityValue = Strings.tr("Localizable", "VirtualCard.hiddenNumberAccessibilityValue", fallback: "Hidden number")
    /// Hide card details
    internal static let hideDetails = Strings.tr("Localizable", "VirtualCard.hideDetails", fallback: "Hide card details")
    /// Activate the card to use it again
    internal static let inactiveDescription = Strings.tr("Localizable", "VirtualCard.inactiveDescription", fallback: "Activate the card to use it again")
    /// Virtual card locked
    internal static let inactiveTitle = Strings.tr("Localizable", "VirtualCard.inactiveTitle", fallback: "Virtual card locked")
    /// Learn more
    internal static let learnMore = Strings.tr("Localizable", "VirtualCard.learnMore", fallback: "Learn more")
    /// Monthly spending
    internal static let monthlyExpenses = Strings.tr("Localizable", "VirtualCard.monthlyExpenses", fallback: "Monthly spending")
    /// %d%% of the limit used
    internal static func monthlyUsageFormat(_ p1: Int) -> String {
      return Strings.tr("Localizable", "VirtualCard.monthlyUsageFormat", p1, fallback: "%d%% of the limit used")
    }
    /// Recent transactions
    internal static let recentTransactions = Strings.tr("Localizable", "VirtualCard.recentTransactions", fallback: "Recent transactions")
    /// The virtual card has a different number, expiration date, and CVC than your physical card.
    internal static let securityDescription = Strings.tr("Localizable", "VirtualCard.securityDescription", fallback: "The virtual card has a different number, expiration date, and CVC than your physical card.")
    /// See all
    internal static let seeAll = Strings.tr("Localizable", "VirtualCard.seeAll", fallback: "See all")
    /// Settings
    internal static let settings = Strings.tr("Localizable", "VirtualCard.settings", fallback: "Settings")
    /// Show card details
    internal static let showDetails = Strings.tr("Localizable", "VirtualCard.showDetails", fallback: "Show card details")
    /// Virtual card
    internal static let title = Strings.tr("Localizable", "VirtualCard.title", fallback: "Virtual card")
    /// of %@
    internal static func totalLimitFormat(_ p1: Any) -> String {
      return Strings.tr("Localizable", "VirtualCard.totalLimitFormat", String(describing: p1), fallback: "of %@")
    }
    /// Virtual card unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "VirtualCard.unavailableTitle", fallback: "Virtual card unavailable")
    /// Valid until
    internal static let validUntil = Strings.tr("Localizable", "VirtualCard.validUntil", fallback: "Valid until")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
