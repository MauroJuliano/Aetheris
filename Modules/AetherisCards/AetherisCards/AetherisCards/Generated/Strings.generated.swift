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
  internal enum Common {
    /// Back
    internal static let back = Strings.tr("Localizable", "Common.back", fallback: "Back")
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again")
  }
  internal enum FinancialSummary {
    /// Apple.Com/Bill
    internal static let appleBill = Strings.tr("Localizable", "FinancialSummary.appleBill", fallback: "Apple.Com/Bill")
    /// %d days ago
    internal static func daysAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.daysAgo", p1, fallback: "%d days ago")
    }
    /// Ifd* Bar do zé
    internal static let ifoodBar = Strings.tr("Localizable", "FinancialSummary.ifoodBar", fallback: "Ifd* Bar do zé")
    /// %d month ago
    internal static func monthAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.monthAgo", p1, fallback: "%d month ago")
    }
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "FinancialSummary.netflix", fallback: "Netflix")
    /// Payment received
    internal static let paymentReceived = Strings.tr("Localizable", "FinancialSummary.paymentReceived", fallback: "Payment received")
    /// Funds received from Ed Sheeran
    internal static let paymentReceivedDescription = Strings.tr("Localizable", "FinancialSummary.paymentReceivedDescription", fallback: "Funds received from Ed Sheeran")
    /// Restaurant
    internal static let restaurant = Strings.tr("Localizable", "FinancialSummary.restaurant", fallback: "Restaurant")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "FinancialSummary.subscription", fallback: "Subscription")
    /// Transfer sent
    internal static let transferSent = Strings.tr("Localizable", "FinancialSummary.transferSent", fallback: "Transfer sent")
    /// Funds successfully transferred to Adele
    internal static let transferSentAdeleDescription = Strings.tr("Localizable", "FinancialSummary.transferSentAdeleDescription", fallback: "Funds successfully transferred to Adele")
    /// Funds successfully transferred to Melissa
    internal static let transferSentDescription = Strings.tr("Localizable", "FinancialSummary.transferSentDescription", fallback: "Funds successfully transferred to Melissa")
  }
  internal enum HomeCard {
    /// Cards unavailable
    internal static let cardsUnavailableTitle = Strings.tr("Localizable", "HomeCard.cardsUnavailableTitle", fallback: "Cards unavailable")
    /// This area will reflect the dashboard when the simulated service returns data.
    internal static let emptyDescription = Strings.tr("Localizable", "HomeCard.emptyDescription", fallback: "This area will reflect the dashboard when the simulated service returns data.")
    /// No cards or activity yet
    internal static let emptyTitle = Strings.tr("Localizable", "HomeCard.emptyTitle", fallback: "No cards or activity yet")
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
  internal enum TransactionHistory {
    /// This account does not have transaction history in the simulated dataset.
    internal static let emptyDescription = Strings.tr("Localizable", "TransactionHistory.emptyDescription", fallback: "This account does not have transaction history in the simulated dataset.")
    /// No transactions yet
    internal static let emptyTitle = Strings.tr("Localizable", "TransactionHistory.emptyTitle", fallback: "No transactions yet")
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
    /// Melissa
    internal static let melissa = Strings.tr("Localizable", "TransactionsHistory.melissa", fallback: "Melissa")
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
