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
    internal static var title: String { Strings.tr("Localizable", "CardHome.title", fallback: "Cards") }
  }
  internal enum CardInformation {
    /// Available limit
    internal static var availableLimit: String { Strings.tr("Localizable", "CardInformation.availableLimit", fallback: "Available limit") }
    /// Closed
    internal static var closedInvoice: String { Strings.tr("Localizable", "CardInformation.closedInvoice", fallback: "Closed") }
    /// Current invoice
    internal static var currentInvoice: String { Strings.tr("Localizable", "CardInformation.currentInvoice", fallback: "Current invoice") }
    /// Due date
    internal static var dueDate: String { Strings.tr("Localizable", "CardInformation.dueDate", fallback: "Due date") }
    /// Due soon
    internal static var dueSoon: String { Strings.tr("Localizable", "CardInformation.dueSoon", fallback: "Due soon") }
    /// Lock
    internal static var lock: String { Strings.tr("Localizable", "CardInformation.lock", fallback: "Lock") }
    /// Open
    internal static var openInvoice: String { Strings.tr("Localizable", "CardInformation.openInvoice", fallback: "Open") }
    /// of %@
    internal static func totalLimit(_ p1: Any) -> String {
      return Strings.tr("Localizable", "CardInformation.totalLimit", String(describing: p1), fallback: "of %@")
    }
    /// Unlock
    internal static var unlock: String { Strings.tr("Localizable", "CardInformation.unlock", fallback: "Unlock") }
    /// Virtual card
    internal static var virtualCard: String { Strings.tr("Localizable", "CardInformation.virtualCard", fallback: "Virtual card") }
    /// Virtual
    /// card
    internal static var virtualCardQuickAction: String { Strings.tr("Localizable", "CardInformation.virtualCardQuickAction", fallback: "Virtual\ncard") }
  }
  internal enum CardLock {
    /// LOCKED
    internal static var blocked: String { Strings.tr("Localizable", "CardLock.blocked", fallback: "LOCKED") }
    /// Your card is locked. Unlock it when you are ready to use it again.
    internal static var blockedDescription: String { Strings.tr("Localizable", "CardLock.blockedDescription", fallback: "Your card is locked. Unlock it when you are ready to use it again.") }
    /// While locked, new purchases and withdrawals are not allowed.
    internal static var blockedStatusDescription: String { Strings.tr("Localizable", "CardLock.blockedStatusDescription", fallback: "While locked, new purchases and withdrawals are not allowed.") }
    /// Your card is locked
    internal static var cardIsBlocked: String { Strings.tr("Localizable", "CardLock.cardIsBlocked", fallback: "Your card is locked") }
    /// Your card is unlocked
    internal static var cardIsUnlocked: String { Strings.tr("Localizable", "CardLock.cardIsUnlocked", fallback: "Your card is unlocked") }
    /// Card settings
    internal static var cardSettings: String { Strings.tr("Localizable", "CardLock.cardSettings", fallback: "Card settings") }
    /// Limits, international usage, and other preferences
    internal static var cardSettingsDescription: String { Strings.tr("Localizable", "CardLock.cardSettingsDescription", fallback: "Limits, international usage, and other preferences") }
    /// Digital wallets and contactless payments will not work.
    internal static var contactlessDisabledDescription: String { Strings.tr("Localizable", "CardLock.contactlessDisabledDescription", fallback: "Digital wallets and contactless payments will not work.") }
    /// Contactless payments are disabled
    internal static var contactlessDisabledTitle: String { Strings.tr("Localizable", "CardLock.contactlessDisabledTitle", fallback: "Contactless payments are disabled") }
    /// We could not find the data needed to manage this card.
    internal static var emptyDescription: String { Strings.tr("Localizable", "CardLock.emptyDescription", fallback: "We could not find the data needed to manage this card.") }
    /// Card not found
    internal static var emptyTitle: String { Strings.tr("Localizable", "CardLock.emptyTitle", fallback: "Card not found") }
    /// Lock card
    internal static var lockCard: String { Strings.tr("Localizable", "CardLock.lockCard", fallback: "Lock card") }
    /// New purchases, withdrawals, and payments will be declined until you unlock the card.
    internal static var lockConfirmationDescription: String { Strings.tr("Localizable", "CardLock.lockConfirmationDescription", fallback: "New purchases, withdrawals, and payments will be declined until you unlock the card.") }
    /// Lock this card?
    internal static var lockConfirmationTitle: String { Strings.tr("Localizable", "CardLock.lockConfirmationTitle", fallback: "Lock this card?") }
    /// Lock card
    internal static var lockTitle: String { Strings.tr("Localizable", "CardLock.lockTitle", fallback: "Lock card") }
    /// Locking the card does not affect your account balance or current invoice.
    internal static var moneyIsSafeDescription: String { Strings.tr("Localizable", "CardLock.moneyIsSafeDescription", fallback: "Locking the card does not affect your account balance or current invoice.") }
    /// Your money is safe
    internal static var moneyIsSafeTitle: String { Strings.tr("Localizable", "CardLock.moneyIsSafeTitle", fallback: "Your money is safe") }
    /// Other options
    internal static var otherOptions: String { Strings.tr("Localizable", "CardLock.otherOptions", fallback: "Other options") }
    /// You will not be able to make in-person or online purchases.
    internal static var purchasesRefusedDescription: String { Strings.tr("Localizable", "CardLock.purchasesRefusedDescription", fallback: "You will not be able to make in-person or online purchases.") }
    /// New purchases are declined
    internal static var purchasesRefusedTitle: String { Strings.tr("Localizable", "CardLock.purchasesRefusedTitle", fallback: "New purchases are declined") }
    /// Request new card
    internal static var requestNewCard: String { Strings.tr("Localizable", "CardLock.requestNewCard", fallback: "Request new card") }
    /// In case of loss, theft, or damage
    internal static var requestNewCardDescription: String { Strings.tr("Localizable", "CardLock.requestNewCardDescription", fallback: "In case of loss, theft, or damage") }
    /// Recurring services linked to this card may be interrupted.
    internal static var subscriptionsAffectedDescription: String { Strings.tr("Localizable", "CardLock.subscriptionsAffectedDescription", fallback: "Recurring services linked to this card may be interrupted.") }
    /// Subscriptions may be affected
    internal static var subscriptionsAffectedTitle: String { Strings.tr("Localizable", "CardLock.subscriptionsAffectedTitle", fallback: "Subscriptions may be affected") }
    /// Card status
    internal static var title: String { Strings.tr("Localizable", "CardLock.title", fallback: "Card status") }
    /// We could not load this card
    internal static var unavailableTitle: String { Strings.tr("Localizable", "CardLock.unavailableTitle", fallback: "We could not load this card") }
    /// UNLOCKED
    internal static var unblocked: String { Strings.tr("Localizable", "CardLock.unblocked", fallback: "UNLOCKED") }
    /// Manage your physical card status securely and with full control.
    internal static var unblockedDescription: String { Strings.tr("Localizable", "CardLock.unblockedDescription", fallback: "Manage your physical card status securely and with full control.") }
    /// Your card is active and ready for purchases, withdrawals, and payments.
    internal static var unblockedStatusDescription: String { Strings.tr("Localizable", "CardLock.unblockedStatusDescription", fallback: "Your card is active and ready for purchases, withdrawals, and payments.") }
    /// Unlock card
    internal static var unlockCard: String { Strings.tr("Localizable", "CardLock.unlockCard", fallback: "Unlock card") }
    /// The card will work again for purchases, withdrawals, and payments.
    internal static var unlockConfirmationDescription: String { Strings.tr("Localizable", "CardLock.unlockConfirmationDescription", fallback: "The card will work again for purchases, withdrawals, and payments.") }
    /// Unlock this card?
    internal static var unlockConfirmationTitle: String { Strings.tr("Localizable", "CardLock.unlockConfirmationTitle", fallback: "Unlock this card?") }
    /// Unlock card
    internal static var unlockTitle: String { Strings.tr("Localizable", "CardLock.unlockTitle", fallback: "Unlock card") }
    /// Valid until
    internal static var validUntil: String { Strings.tr("Localizable", "CardLock.validUntil", fallback: "Valid until") }
    /// Virtual card
    internal static var virtualCard: String { Strings.tr("Localizable", "CardLock.virtualCard", fallback: "Virtual card") }
    /// Manage your virtual card
    internal static var virtualCardDescription: String { Strings.tr("Localizable", "CardLock.virtualCardDescription", fallback: "Manage your virtual card") }
    /// What happens when you lock it
    internal static var whenBlockingTitle: String { Strings.tr("Localizable", "CardLock.whenBlockingTitle", fallback: "What happens when you lock it") }
    /// While your card is locked
    internal static var whileBlockedTitle: String { Strings.tr("Localizable", "CardLock.whileBlockedTitle", fallback: "While your card is locked") }
    /// Cash withdrawals will not be allowed.
    internal static var withdrawalsDisabledDescription: String { Strings.tr("Localizable", "CardLock.withdrawalsDisabledDescription", fallback: "Cash withdrawals will not be allowed.") }
    /// Withdrawals are disabled
    internal static var withdrawalsDisabledTitle: String { Strings.tr("Localizable", "CardLock.withdrawalsDisabledTitle", fallback: "Withdrawals are disabled") }
  }
  internal enum Common {
    /// Back
    internal static var back: String { Strings.tr("Localizable", "Common.back", fallback: "Back") }
    /// Cancel
    internal static var cancel: String { Strings.tr("Localizable", "Common.cancel", fallback: "Cancel") }
    /// OK
    internal static var ok: String { Strings.tr("Localizable", "Common.ok", fallback: "OK") }
    /// See all
    internal static var seeAll: String { Strings.tr("Localizable", "Common.seeAll", fallback: "See all") }
    /// Try again
    internal static var tryAgain: String { Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again") }
  }
  internal enum CurrentInvoice {
    /// Available limit
    internal static var availableLimit: String { Strings.tr("Localizable", "CurrentInvoice.availableLimit", fallback: "Available limit") }
    /// Best purchase date
    internal static var bestPurchaseDate: String { Strings.tr("Localizable", "CurrentInvoice.bestPurchaseDate", fallback: "Best purchase date") }
    /// Close notice
    internal static var closeNotice: String { Strings.tr("Localizable", "CurrentInvoice.closeNotice", fallback: "Close notice") }
    /// %d days until due
    internal static func daysUntilDue(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.daysUntilDue", p1, fallback: "%d days until due")
    }
    /// Track your invoice amount, due date, and spending details for this period.
    internal static var description: String { Strings.tr("Localizable", "CurrentInvoice.description", fallback: "Track your invoice amount, due date, and spending details for this period.") }
    /// Invoice details
    internal static var detailsTitle: String { Strings.tr("Localizable", "CurrentInvoice.detailsTitle", fallback: "Invoice details") }
    /// Discounts and credits
    internal static var discountsAndCredits: String { Strings.tr("Localizable", "CurrentInvoice.discountsAndCredits", fallback: "Discounts and credits") }
    /// Payments and refunds
    internal static var discountsAndCreditsDescription: String { Strings.tr("Localizable", "CurrentInvoice.discountsAndCreditsDescription", fallback: "Payments and refunds") }
    /// Due date
    internal static var dueDate: String { Strings.tr("Localizable", "CurrentInvoice.dueDate", fallback: "Due date") }
    /// Due today
    internal static var dueToday: String { Strings.tr("Localizable", "CurrentInvoice.dueToday", fallback: "Due today") }
    /// When you make purchases with your card, transactions will appear here.
    internal static var emptyDescription: String { Strings.tr("Localizable", "CurrentInvoice.emptyDescription", fallback: "When you make purchases with your card, transactions will appear here.") }
    /// No invoice available
    internal static var emptyTitle: String { Strings.tr("Localizable", "CurrentInvoice.emptyTitle", fallback: "No invoice available") }
    /// Installments
    internal static var installment: String { Strings.tr("Localizable", "CurrentInvoice.installment", fallback: "Installments") }
    /// %d percent installments
    internal static func installmentAccessibilityValue(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.installmentAccessibilityValue", p1, fallback: "%d percent installments")
    }
    /// Invoice total
    internal static var invoiceTotal: String { Strings.tr("Localizable", "CurrentInvoice.invoiceTotal", fallback: "Invoice total") }
    /// Pay by the due date to avoid interest and keep your limit available.
    internal static var noticeDescription: String { Strings.tr("Localizable", "CurrentInvoice.noticeDescription", fallback: "Pay by the due date to avoid interest and keep your limit available.") }
    /// Open invoice
    internal static var noticeTitle: String { Strings.tr("Localizable", "CurrentInvoice.noticeTitle", fallback: "Open invoice") }
    /// 1 day until due
    internal static var oneDayUntilDue: String { Strings.tr("Localizable", "CurrentInvoice.oneDayUntilDue", fallback: "1 day until due") }
    /// One-time
    internal static var oneTime: String { Strings.tr("Localizable", "CurrentInvoice.oneTime", fallback: "One-time") }
    /// Other charges
    internal static var otherCharges: String { Strings.tr("Localizable", "CurrentInvoice.otherCharges", fallback: "Other charges") }
    /// Fees, charges, and adjustments
    internal static var otherChargesDescription: String { Strings.tr("Localizable", "CurrentInvoice.otherChargesDescription", fallback: "Fees, charges, and adjustments") }
    /// Payment overdue
    internal static var overduePayment: String { Strings.tr("Localizable", "CurrentInvoice.overduePayment", fallback: "Payment overdue") }
    /// Invoice paid
    internal static var paidInvoice: String { Strings.tr("Localizable", "CurrentInvoice.paidInvoice", fallback: "Invoice paid") }
    /// Pay invoice
    internal static var payInvoice: String { Strings.tr("Localizable", "CurrentInvoice.payInvoice", fallback: "Pay invoice") }
    /// Purchases subtotal
    internal static var purchasesSubtotal: String { Strings.tr("Localizable", "CurrentInvoice.purchasesSubtotal", fallback: "Purchases subtotal") }
    /// Domestic and international purchases
    internal static var purchasesSubtotalDescription: String { Strings.tr("Localizable", "CurrentInvoice.purchasesSubtotalDescription", fallback: "Domestic and international purchases") }
    /// See charts
    internal static var seeCharts: String { Strings.tr("Localizable", "CurrentInvoice.seeCharts", fallback: "See charts") }
    /// Spending distribution
    internal static var spendingDistribution: String { Strings.tr("Localizable", "CurrentInvoice.spendingDistribution", fallback: "Spending distribution") }
    /// Spending summary
    internal static var spendingSummaryTitle: String { Strings.tr("Localizable", "CurrentInvoice.spendingSummaryTitle", fallback: "Spending summary") }
    /// Current invoice
    internal static var title: String { Strings.tr("Localizable", "CurrentInvoice.title", fallback: "Current invoice") }
    /// Total invoice amount
    internal static var totalAmount: String { Strings.tr("Localizable", "CurrentInvoice.totalAmount", fallback: "Total invoice amount") }
    /// Total limit
    internal static var totalLimit: String { Strings.tr("Localizable", "CurrentInvoice.totalLimit", fallback: "Total limit") }
    /// Total spent this period
    internal static var totalSpent: String { Strings.tr("Localizable", "CurrentInvoice.totalSpent", fallback: "Total spent this period") }
    /// We could not load your invoice
    internal static var unavailableTitle: String { Strings.tr("Localizable", "CurrentInvoice.unavailableTitle", fallback: "We could not load your invoice") }
    /// Used limit
    internal static var usedLimit: String { Strings.tr("Localizable", "CurrentInvoice.usedLimit", fallback: "Used limit") }
    /// %d%% of limit
    internal static func usedLimitPercentage(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.usedLimitPercentage", p1, fallback: "%d%% of limit")
    }
    internal enum Status {
      /// Closed
      internal static var closed: String { Strings.tr("Localizable", "CurrentInvoice.Status.closed", fallback: "Closed") }
      /// Open
      internal static var `open`: String { Strings.tr("Localizable", "CurrentInvoice.Status.open", fallback: "Open") }
      /// Overdue
      internal static var overdue: String { Strings.tr("Localizable", "CurrentInvoice.Status.overdue", fallback: "Overdue") }
      /// Paid
      internal static var paid: String { Strings.tr("Localizable", "CurrentInvoice.Status.paid", fallback: "Paid") }
    }
  }
  internal enum FinancialSummary {
    /// Apple.Com/Bill
    internal static var appleBill: String { Strings.tr("Localizable", "FinancialSummary.appleBill", fallback: "Apple.Com/Bill") }
    /// %d days ago
    internal static func daysAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.daysAgo", p1, fallback: "%d days ago")
    }
    /// Ifd* Joe's Bar
    internal static var ifoodBar: String { Strings.tr("Localizable", "FinancialSummary.ifoodBar", fallback: "Ifd* Joe's Bar") }
    /// %d month ago
    internal static func monthAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.monthAgo", p1, fallback: "%d month ago")
    }
    /// Netflix
    internal static var netflix: String { Strings.tr("Localizable", "FinancialSummary.netflix", fallback: "Netflix") }
    /// Payment received
    internal static var paymentReceived: String { Strings.tr("Localizable", "FinancialSummary.paymentReceived", fallback: "Payment received") }
    /// Funds received from Amelia Thompson
    internal static var paymentReceivedDescription: String { Strings.tr("Localizable", "FinancialSummary.paymentReceivedDescription", fallback: "Funds received from Amelia Thompson") }
    /// Funds received from %@
    internal static func paymentReceivedFrom(_ p1: Any) -> String {
      return Strings.tr("Localizable", "FinancialSummary.paymentReceivedFrom", String(describing: p1), fallback: "Funds received from %@")
    }
    /// Restaurant
    internal static var restaurant: String { Strings.tr("Localizable", "FinancialSummary.restaurant", fallback: "Restaurant") }
    /// Subscription
    internal static var subscription: String { Strings.tr("Localizable", "FinancialSummary.subscription", fallback: "Subscription") }
    /// Transfer sent
    internal static var transferSent: String { Strings.tr("Localizable", "FinancialSummary.transferSent", fallback: "Transfer sent") }
    /// Funds successfully transferred to Amelia Thompson
    internal static var transferSentAmeliaDescription: String { Strings.tr("Localizable", "FinancialSummary.transferSentAmeliaDescription", fallback: "Funds successfully transferred to Amelia Thompson") }
    /// Funds successfully transferred to Sophie Keller
    internal static var transferSentDescription: String { Strings.tr("Localizable", "FinancialSummary.transferSentDescription", fallback: "Funds successfully transferred to Sophie Keller") }
    /// Funds successfully transferred to %@
    internal static func transferSentTo(_ p1: Any) -> String {
      return Strings.tr("Localizable", "FinancialSummary.transferSentTo", String(describing: p1), fallback: "Funds successfully transferred to %@")
    }
  }
  internal enum HomeCard {
    /// Cards unavailable
    internal static var cardsUnavailableTitle: String { Strings.tr("Localizable", "HomeCard.cardsUnavailableTitle", fallback: "Cards unavailable") }
    /// This area will reflect the dashboard when the simulated service returns data.
    internal static var emptyDescription: String { Strings.tr("Localizable", "HomeCard.emptyDescription", fallback: "This area will reflect the dashboard when the simulated service returns data.") }
    /// No cards or activity yet
    internal static var emptyTitle: String { Strings.tr("Localizable", "HomeCard.emptyTitle", fallback: "No cards or activity yet") }
    /// We could not load your cards and activity right now.
    internal static var loadFailed: String { Strings.tr("Localizable", "HomeCard.loadFailed", fallback: "We could not load your cards and activity right now.") }
  }
  internal enum Mock {
    /// Account balance
    internal static var accountBalance: String { Strings.tr("Localizable", "Mock.accountBalance", fallback: "Account balance") }
    /// Aetheris account
    internal static var aetherisAccount: String { Strings.tr("Localizable", "Mock.aetherisAccount", fallback: "Aetheris account") }
    /// Aetheris checking
    internal static var aetherisChecking: String { Strings.tr("Localizable", "Mock.aetherisChecking", fallback: "Aetheris checking") }
    /// August 2026
    internal static var august2026: String { Strings.tr("Localizable", "Mock.august2026", fallback: "August 2026") }
    /// Bank transfer
    internal static var bankTransfer: String { Strings.tr("Localizable", "Mock.bankTransfer", fallback: "Bank transfer") }
    /// Concert ticket
    internal static var concertTicket: String { Strings.tr("Localizable", "Mock.concertTicket", fallback: "Concert ticket") }
    /// Dinner split
    internal static var dinnerSplit: String { Strings.tr("Localizable", "Mock.dinnerSplit", fallback: "Dinner split") }
    /// Dinner with Sophie Keller
    internal static var dinnerWithSophie: String { Strings.tr("Localizable", "Mock.dinnerWithSophie", fallback: "Dinner with Sophie Keller") }
    /// Entertainment
    internal static var entertainment: String { Strings.tr("Localizable", "Mock.entertainment", fallback: "Entertainment") }
    /// Instant payment
    internal static var instantPayment: String { Strings.tr("Localizable", "Mock.instantPayment", fallback: "Instant payment") }
    /// Instant transfer
    internal static var instantTransfer: String { Strings.tr("Localizable", "Mock.instantTransfer", fallback: "Instant transfer") }
    /// Invoice payment
    internal static var invoicePayment: String { Strings.tr("Localizable", "Mock.invoicePayment", fallback: "Invoice payment") }
    /// Loading
    internal static var loading: String { Strings.tr("Localizable", "Mock.loading", fallback: "Loading") }
    /// Merchant refund
    internal static var merchantRefund: String { Strings.tr("Localizable", "Mock.merchantRefund", fallback: "Merchant refund") }
    /// Original purchase refunded
    internal static var originalPurchaseRefunded: String { Strings.tr("Localizable", "Mock.originalPurchaseRefunded", fallback: "Original purchase refunded") }
    /// Payment received
    internal static var paymentReceived: String { Strings.tr("Localizable", "Mock.paymentReceived", fallback: "Payment received") }
    /// Personal transfer
    internal static var personalTransfer: String { Strings.tr("Localizable", "Mock.personalTransfer", fallback: "Personal transfer") }
    /// Physical card
    internal static var physicalCard: String { Strings.tr("Localizable", "Mock.physicalCard", fallback: "Physical card") }
    /// Refund
    internal static var refund: String { Strings.tr("Localizable", "Mock.refund", fallback: "Refund") }
    /// Restaurant
    internal static var restaurant: String { Strings.tr("Localizable", "Mock.restaurant", fallback: "Restaurant") }
    /// Sao Paulo, Brazil
    internal static var saoPauloBrazil: String { Strings.tr("Localizable", "Mock.saoPauloBrazil", fallback: "Sao Paulo, Brazil") }
    /// Thanks for the collaboration
    internal static var thanksForCollaboration: String { Strings.tr("Localizable", "Mock.thanksForCollaboration", fallback: "Thanks for the collaboration") }
    /// Transaction
    internal static var transaction: String { Strings.tr("Localizable", "Mock.transaction", fallback: "Transaction") }
    /// Unknown merchant
    internal static var unknownMerchant: String { Strings.tr("Localizable", "Mock.unknownMerchant", fallback: "Unknown merchant") }
    /// Virtual card
    internal static var virtualCard: String { Strings.tr("Localizable", "Mock.virtualCard", fallback: "Virtual card") }
  }
  internal enum Notifications {
    /// Last Month
    internal static var sectionLastMonth: String { Strings.tr("Localizable", "Notifications.sectionLastMonth", fallback: "Last Month") }
    /// Last Week
    internal static var sectionLastWeek: String { Strings.tr("Localizable", "Notifications.sectionLastWeek", fallback: "Last Week") }
    /// Others
    internal static var sectionOthers: String { Strings.tr("Localizable", "Notifications.sectionOthers", fallback: "Others") }
    /// Today
    internal static var sectionToday: String { Strings.tr("Localizable", "Notifications.sectionToday", fallback: "Today") }
    /// Yesterday
    internal static var sectionYesterday: String { Strings.tr("Localizable", "Notifications.sectionYesterday", fallback: "Yesterday") }
  }
  internal enum QuickActions {
    /// All services
    internal static var moreSubtitle: String { Strings.tr("Localizable", "QuickActions.moreSubtitle", fallback: "All services") }
    /// More
    internal static var moreTitle: String { Strings.tr("Localizable", "QuickActions.moreTitle", fallback: "More") }
    /// Pay bills
    internal static var paySubtitle: String { Strings.tr("Localizable", "QuickActions.paySubtitle", fallback: "Pay bills") }
    /// Pay
    internal static var payTitle: String { Strings.tr("Localizable", "QuickActions.payTitle", fallback: "Pay") }
    /// Receive money
    internal static var requestSubtitle: String { Strings.tr("Localizable", "QuickActions.requestSubtitle", fallback: "Receive money") }
    /// Request
    internal static var requestTitle: String { Strings.tr("Localizable", "QuickActions.requestTitle", fallback: "Request") }
    /// What would you like to do ?
    internal static var sectionTitle: String { Strings.tr("Localizable", "QuickActions.sectionTitle", fallback: "What would you like to do ?") }
    /// Send
    internal static var sendTitle: String { Strings.tr("Localizable", "QuickActions.sendTitle", fallback: "Send") }
    /// Add funds
    internal static var topUpSubtitle: String { Strings.tr("Localizable", "QuickActions.topUpSubtitle", fallback: "Add funds") }
    /// Top up
    internal static var topUpTitle: String { Strings.tr("Localizable", "QuickActions.topUpTitle", fallback: "Top up") }
    /// Send money
    internal static var transferSubtitle: String { Strings.tr("Localizable", "QuickActions.transferSubtitle", fallback: "Send money") }
    /// Transfer
    internal static var transferTitle: String { Strings.tr("Localizable", "QuickActions.transferTitle", fallback: "Transfer") }
  }
  internal enum TransactionDetails {
    /// Add note
    internal static var addNote: String { Strings.tr("Localizable", "TransactionDetails.addNote", fallback: "Add note") }
    /// Allow future payments
    internal static var allowFuturePayments: String { Strings.tr("Localizable", "TransactionDetails.allowFuturePayments", fallback: "Allow future payments") }
    /// Future charges from this merchant will be allowed again.
    internal static var allowFuturePaymentsDescription: String { Strings.tr("Localizable", "TransactionDetails.allowFuturePaymentsDescription", fallback: "Future charges from this merchant will be allowed again.") }
    /// Amount
    internal static var amount: String { Strings.tr("Localizable", "TransactionDetails.amount", fallback: "Amount") }
    /// Billing frequency
    internal static var billingFrequency: String { Strings.tr("Localizable", "TransactionDetails.billingFrequency", fallback: "Billing frequency") }
    /// Block future payments
    internal static var blockFuturePayments: String { Strings.tr("Localizable", "TransactionDetails.blockFuturePayments", fallback: "Block future payments") }
    /// Future charges from this merchant will be declined.
    internal static var blockFuturePaymentsDescription: String { Strings.tr("Localizable", "TransactionDetails.blockFuturePaymentsDescription", fallback: "Future charges from this merchant will be declined.") }
    /// Cancelled
    internal static var cancelled: String { Strings.tr("Localizable", "TransactionDetails.cancelled", fallback: "Cancelled") }
    /// Category
    internal static var category: String { Strings.tr("Localizable", "TransactionDetails.category", fallback: "Category") }
    /// Completed
    internal static var completed: String { Strings.tr("Localizable", "TransactionDetails.completed", fallback: "Completed") }
    /// Confirmation code
    internal static var confirmationCode: String { Strings.tr("Localizable", "TransactionDetails.confirmationCode", fallback: "Confirmation code") }
    /// Date
    internal static var date: String { Strings.tr("Localizable", "TransactionDetails.date", fallback: "Date") }
    /// Declined
    internal static var declined: String { Strings.tr("Localizable", "TransactionDetails.declined", fallback: "Declined") }
    /// Download
    internal static var download: String { Strings.tr("Localizable", "TransactionDetails.download", fallback: "Download") }
    /// We couldn't find the details for this transaction.
    internal static var emptyDescription: String { Strings.tr("Localizable", "TransactionDetails.emptyDescription", fallback: "We couldn't find the details for this transaction.") }
    /// Transaction not found
    internal static var emptyTitle: String { Strings.tr("Localizable", "TransactionDetails.emptyTitle", fallback: "Transaction not found") }
    /// Something went wrong
    internal static var errorTitle: String { Strings.tr("Localizable", "TransactionDetails.errorTitle", fallback: "Something went wrong") }
    /// Expected amount
    internal static var expectedAmount: String { Strings.tr("Localizable", "TransactionDetails.expectedAmount", fallback: "Expected amount") }
    /// Expected availability
    internal static var expectedAvailability: String { Strings.tr("Localizable", "TransactionDetails.expectedAvailability", fallback: "Expected availability") }
    /// From
    internal static var from: String { Strings.tr("Localizable", "TransactionDetails.from", fallback: "From") }
    /// Get support
    internal static var getSupport: String { Strings.tr("Localizable", "TransactionDetails.getSupport", fallback: "Get support") }
    /// Income
    internal static var income: String { Strings.tr("Localizable", "TransactionDetails.income", fallback: "Income") }
    /// Institution
    internal static var institution: String { Strings.tr("Localizable", "TransactionDetails.institution", fallback: "Institution") }
    /// Invoice
    internal static var invoice: String { Strings.tr("Localizable", "TransactionDetails.invoice", fallback: "Invoice") }
    /// Invoice payment
    internal static var invoicePayment: String { Strings.tr("Localizable", "TransactionDetails.invoicePayment", fallback: "Invoice payment") }
    /// Invoice payment details
    internal static var invoicePaymentDetails: String { Strings.tr("Localizable", "TransactionDetails.invoicePaymentDetails", fallback: "Invoice payment details") }
    /// Location
    internal static var location: String { Strings.tr("Localizable", "TransactionDetails.location", fallback: "Location") }
    /// Merchant
    internal static var merchant: String { Strings.tr("Localizable", "TransactionDetails.merchant", fallback: "Merchant") }
    /// Method
    internal static var method: String { Strings.tr("Localizable", "TransactionDetails.method", fallback: "Method") }
    /// Monthly
    internal static var monthly: String { Strings.tr("Localizable", "TransactionDetails.monthly", fallback: "Monthly") }
    /// Need help?
    internal static var needHelp: String { Strings.tr("Localizable", "TransactionDetails.needHelp", fallback: "Need help?") }
    /// Next expected payment: %@
    internal static func nextExpectedPayment(_ p1: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.nextExpectedPayment", String(describing: p1), fallback: "Next expected payment: %@")
    }
    /// Next expected payment
    internal static var nextPayment: String { Strings.tr("Localizable", "TransactionDetails.nextPayment", fallback: "Next expected payment") }
    /// Note
    internal static var note: String { Strings.tr("Localizable", "TransactionDetails.note", fallback: "Note") }
    /// Not identified
    internal static var notIdentified: String { Strings.tr("Localizable", "TransactionDetails.notIdentified", fallback: "Not identified") }
    /// Original transaction
    internal static var originalTransaction: String { Strings.tr("Localizable", "TransactionDetails.originalTransaction", fallback: "Original transaction") }
    /// Paid amount
    internal static var paidAmount: String { Strings.tr("Localizable", "TransactionDetails.paidAmount", fallback: "Paid amount") }
    /// Payment details
    internal static var paymentDetails: String { Strings.tr("Localizable", "TransactionDetails.paymentDetails", fallback: "Payment details") }
    /// Payment history
    internal static var paymentHistory: String { Strings.tr("Localizable", "TransactionDetails.paymentHistory", fallback: "Payment history") }
    /// Payment method
    internal static var paymentMethod: String { Strings.tr("Localizable", "TransactionDetails.paymentMethod", fallback: "Payment method") }
    /// Pending
    internal static var pending: String { Strings.tr("Localizable", "TransactionDetails.pending", fallback: "Pending") }
    /// Processing
    internal static var processing: String { Strings.tr("Localizable", "TransactionDetails.processing", fallback: "Processing") }
    /// Purchase
    internal static var purchase: String { Strings.tr("Localizable", "TransactionDetails.purchase", fallback: "Purchase") }
    /// Purchase details
    internal static var purchaseDetails: String { Strings.tr("Localizable", "TransactionDetails.purchaseDetails", fallback: "Purchase details") }
    /// Every three months
    internal static var quarterly: String { Strings.tr("Localizable", "TransactionDetails.quarterly", fallback: "Every three months") }
    /// Reason
    internal static var reason: String { Strings.tr("Localizable", "TransactionDetails.reason", fallback: "Reason") }
    /// %@ usually charges %@ every month.
    internal static func recurringMonthly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringMonthly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every month.")
    }
    /// Recurring payment
    internal static var recurringPayment: String { Strings.tr("Localizable", "TransactionDetails.recurringPayment", fallback: "Recurring payment") }
    /// %@ usually charges %@ every three months.
    internal static func recurringQuarterly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringQuarterly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every three months.")
    }
    /// We identified similar recurring payments from this merchant.
    internal static var recurringUnknown: String { Strings.tr("Localizable", "TransactionDetails.recurringUnknown", fallback: "We identified similar recurring payments from this merchant.") }
    /// %@ usually charges %@ every week.
    internal static func recurringWeekly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringWeekly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every week.")
    }
    /// %@ usually charges %@ every year.
    internal static func recurringYearly(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransactionDetails.recurringYearly", String(describing: p1), String(describing: p2), fallback: "%@ usually charges %@ every year.")
    }
    /// Reference
    internal static var reference: String { Strings.tr("Localizable", "TransactionDetails.reference", fallback: "Reference") }
    /// Refund
    internal static var refund: String { Strings.tr("Localizable", "TransactionDetails.refund", fallback: "Refund") }
    /// Refund details
    internal static var refundDetails: String { Strings.tr("Localizable", "TransactionDetails.refundDetails", fallback: "Refund details") }
    /// Refunded
    internal static var refundedStatus: String { Strings.tr("Localizable", "TransactionDetails.refundedStatus", fallback: "Refunded") }
    /// Report issue
    internal static var reportIssue: String { Strings.tr("Localizable", "TransactionDetails.reportIssue", fallback: "Report issue") }
    /// Share
    internal static var share: String { Strings.tr("Localizable", "TransactionDetails.share", fallback: "Share") }
    /// Status
    internal static var status: String { Strings.tr("Localizable", "TransactionDetails.status", fallback: "Status") }
    /// Subscription
    internal static var subscription: String { Strings.tr("Localizable", "TransactionDetails.subscription", fallback: "Subscription") }
    /// Subscription details
    internal static var subscriptionDetails: String { Strings.tr("Localizable", "TransactionDetails.subscriptionDetails", fallback: "Subscription details") }
    /// If you have any questions about this transaction, we're here to help.
    internal static var supportDescription: String { Strings.tr("Localizable", "TransactionDetails.supportDescription", fallback: "If you have any questions about this transaction, we're here to help.") }
    /// Transaction Details
    internal static var title: String { Strings.tr("Localizable", "TransactionDetails.title", fallback: "Transaction Details") }
    /// To
    internal static var to: String { Strings.tr("Localizable", "TransactionDetails.to", fallback: "To") }
    /// Transaction ID
    internal static var transactionId: String { Strings.tr("Localizable", "TransactionDetails.transactionId", fallback: "Transaction ID") }
    /// Transfer
    internal static var transfer: String { Strings.tr("Localizable", "TransactionDetails.transfer", fallback: "Transfer") }
    /// Transfer details
    internal static var transferDetails: String { Strings.tr("Localizable", "TransactionDetails.transferDetails", fallback: "Transfer details") }
    /// Type
    internal static var type: String { Strings.tr("Localizable", "TransactionDetails.type", fallback: "Type") }
    /// Transaction unavailable
    internal static var unavailableTitle: String { Strings.tr("Localizable", "TransactionDetails.unavailableTitle", fallback: "Transaction unavailable") }
    /// Weekly
    internal static var weekly: String { Strings.tr("Localizable", "TransactionDetails.weekly", fallback: "Weekly") }
    /// Yearly
    internal static var yearly: String { Strings.tr("Localizable", "TransactionDetails.yearly", fallback: "Yearly") }
  }
  internal enum TransactionHistory {
    /// This account does not have transaction history in the simulated dataset.
    internal static var emptyDescription: String { Strings.tr("Localizable", "TransactionHistory.emptyDescription", fallback: "This account does not have transaction history in the simulated dataset.") }
    /// No transactions yet
    internal static var emptyTitle: String { Strings.tr("Localizable", "TransactionHistory.emptyTitle", fallback: "No transactions yet") }
    /// We could not load your transaction history.
    internal static var loadFailed: String { Strings.tr("Localizable", "TransactionHistory.loadFailed", fallback: "We could not load your transaction history.") }
    /// Transaction History
    internal static var title: String { Strings.tr("Localizable", "TransactionHistory.title", fallback: "Transaction History") }
    /// History unavailable
    internal static var unavailableTitle: String { Strings.tr("Localizable", "TransactionHistory.unavailableTitle", fallback: "History unavailable") }
  }
  internal enum TransactionsHistory {
    /// Apple
    internal static var apple: String { Strings.tr("Localizable", "TransactionsHistory.apple", fallback: "Apple") }
    /// Deposit
    internal static var deposit: String { Strings.tr("Localizable", "TransactionsHistory.deposit", fallback: "Deposit") }
    /// Sophie Keller
    internal static var melissa: String { Strings.tr("Localizable", "TransactionsHistory.melissa", fallback: "Sophie Keller") }
    /// Netflix
    internal static var netflix: String { Strings.tr("Localizable", "TransactionsHistory.netflix", fallback: "Netflix") }
    /// Payment
    internal static var payment: String { Strings.tr("Localizable", "TransactionsHistory.payment", fallback: "Payment") }
    /// Purchase
    internal static var purchase: String { Strings.tr("Localizable", "TransactionsHistory.purchase", fallback: "Purchase") }
    /// Salary
    internal static var salary: String { Strings.tr("Localizable", "TransactionsHistory.salary", fallback: "Salary") }
    /// Subscription
    internal static var subscription: String { Strings.tr("Localizable", "TransactionsHistory.subscription", fallback: "Subscription") }
    /// Swarovski
    internal static var swarovski: String { Strings.tr("Localizable", "TransactionsHistory.swarovski", fallback: "Swarovski") }
    /// Transactions History
    internal static var title: String { Strings.tr("Localizable", "TransactionsHistory.title", fallback: "Transactions History") }
    /// Transfer received
    internal static var transferReceived: String { Strings.tr("Localizable", "TransactionsHistory.transferReceived", fallback: "Transfer received") }
  }
  internal enum VirtualCard {
    /// Your card is ready to use
    internal static var activeDescription: String { Strings.tr("Localizable", "VirtualCard.activeDescription", fallback: "Your card is ready to use") }
    /// Virtual card active
    internal static var activeTitle: String { Strings.tr("Localizable", "VirtualCard.activeTitle", fallback: "Virtual card active") }
    /// Available limit
    internal static var availableLimit: String { Strings.tr("Localizable", "VirtualCard.availableLimit", fallback: "Available limit") }
    /// Cancel
    internal static var cancel: String { Strings.tr("Localizable", "VirtualCard.cancel", fallback: "Cancel") }
    /// Card number
    internal static var cardNumberAccessibilityLabel: String { Strings.tr("Localizable", "VirtualCard.cardNumberAccessibilityLabel", fallback: "Card number") }
    /// Virtual
    internal static var cardType: String { Strings.tr("Localizable", "VirtualCard.cardType", fallback: "Virtual") }
    /// Number copied
    internal static var copied: String { Strings.tr("Localizable", "VirtualCard.copied", fallback: "Number copied") }
    /// Copy number
    internal static var copyNumber: String { Strings.tr("Localizable", "VirtualCard.copyNumber", fallback: "Copy number") }
    /// Use your virtual card for online purchases and subscriptions with more security.
    internal static var description: String { Strings.tr("Localizable", "VirtualCard.description", fallback: "Use your virtual card for online purchases and subscriptions with more security.") }
    /// Create a virtual card to make online purchases more securely.
    internal static var emptyDescription: String { Strings.tr("Localizable", "VirtualCard.emptyDescription", fallback: "Create a virtual card to make online purchases more securely.") }
    /// You do not have a virtual card yet
    internal static var emptyTitle: String { Strings.tr("Localizable", "VirtualCard.emptyTitle", fallback: "You do not have a virtual card yet") }
    /// Generate new number
    internal static var generateConfirmationAction: String { Strings.tr("Localizable", "VirtualCard.generateConfirmationAction", fallback: "Generate new number") }
    /// The current number will stop working. Recurring purchases and subscriptions may need to be updated.
    internal static var generateConfirmationMessage: String { Strings.tr("Localizable", "VirtualCard.generateConfirmationMessage", fallback: "The current number will stop working. Recurring purchases and subscriptions may need to be updated.") }
    /// Generate a new number?
    internal static var generateConfirmationTitle: String { Strings.tr("Localizable", "VirtualCard.generateConfirmationTitle", fallback: "Generate a new number?") }
    /// Generate new number
    internal static var generateNewNumber: String { Strings.tr("Localizable", "VirtualCard.generateNewNumber", fallback: "Generate new number") }
    /// Hidden number
    internal static var hiddenNumberAccessibilityValue: String { Strings.tr("Localizable", "VirtualCard.hiddenNumberAccessibilityValue", fallback: "Hidden number") }
    /// Hide card details
    internal static var hideDetails: String { Strings.tr("Localizable", "VirtualCard.hideDetails", fallback: "Hide card details") }
    /// Activate the card to use it again
    internal static var inactiveDescription: String { Strings.tr("Localizable", "VirtualCard.inactiveDescription", fallback: "Activate the card to use it again") }
    /// Virtual card locked
    internal static var inactiveTitle: String { Strings.tr("Localizable", "VirtualCard.inactiveTitle", fallback: "Virtual card locked") }
    /// Learn more
    internal static var learnMore: String { Strings.tr("Localizable", "VirtualCard.learnMore", fallback: "Learn more") }
    /// Monthly spending
    internal static var monthlyExpenses: String { Strings.tr("Localizable", "VirtualCard.monthlyExpenses", fallback: "Monthly spending") }
    /// %d%% of the limit used
    internal static func monthlyUsageFormat(_ p1: Int) -> String {
      return Strings.tr("Localizable", "VirtualCard.monthlyUsageFormat", p1, fallback: "%d%% of the limit used")
    }
    /// Recent transactions
    internal static var recentTransactions: String { Strings.tr("Localizable", "VirtualCard.recentTransactions", fallback: "Recent transactions") }
    /// The virtual card has a different number, expiration date, and CVC than your physical card.
    internal static var securityDescription: String { Strings.tr("Localizable", "VirtualCard.securityDescription", fallback: "The virtual card has a different number, expiration date, and CVC than your physical card.") }
    /// See all
    internal static var seeAll: String { Strings.tr("Localizable", "VirtualCard.seeAll", fallback: "See all") }
    /// Settings
    internal static var settings: String { Strings.tr("Localizable", "VirtualCard.settings", fallback: "Settings") }
    /// Show card details
    internal static var showDetails: String { Strings.tr("Localizable", "VirtualCard.showDetails", fallback: "Show card details") }
    /// Virtual card
    internal static var title: String { Strings.tr("Localizable", "VirtualCard.title", fallback: "Virtual card") }
    /// of %@
    internal static func totalLimitFormat(_ p1: Any) -> String {
      return Strings.tr("Localizable", "VirtualCard.totalLimitFormat", String(describing: p1), fallback: "of %@")
    }
    /// Virtual card unavailable
    internal static var unavailableTitle: String { Strings.tr("Localizable", "VirtualCard.unavailableTitle", fallback: "Virtual card unavailable") }
    /// Valid until
    internal static var validUntil: String { Strings.tr("Localizable", "VirtualCard.validUntil", fallback: "Valid until") }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: BundleToken.locale, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  private static let baseBundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()

  static var bundle: Bundle {
    guard let languageCode else { return baseBundle }

    let candidates = [languageCode, String(languageCode.prefix(2))]
    for candidate in candidates {
      if let path = baseBundle.path(forResource: candidate, ofType: "lproj"),
         let localizedBundle = Bundle(path: path) {
        return localizedBundle
      }
    }

    return baseBundle
  }

  static var locale: Locale {
    languageCode.map(Locale.init(identifier:)) ?? .current
  }

  private static var languageCode: String? {
    switch UserDefaults.standard.string(forKey: "aetheris.selectedLanguage") {
    case "english": "en"
    case "german": "de"
    case "portugueseBrazil": "pt-BR"
    default: Locale.preferredLanguages.first
    }
  }
}
// swiftlint:enable convenience_type
