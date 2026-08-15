// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum AllServices {
    /// Cards
    internal static let cardCenter = Strings.tr("Localizable", "AllServices.cardCenter", fallback: "Cards")
    /// Beneficiaries
    internal static let manageBeneficiaries = Strings.tr("Localizable", "AllServices.manageBeneficiaries", fallback: "Beneficiaries")
    /// Notifications
    internal static let notifications = Strings.tr("Localizable", "AllServices.notifications", fallback: "Notifications")
    /// Reports
    internal static let reports = Strings.tr("Localizable", "AllServices.reports", fallback: "Reports")
    /// Quick access to the main services available in the app.
    internal static let subtitle = Strings.tr("Localizable", "AllServices.subtitle", fallback: "Quick access to the main services available in the app.")
    /// All services
    internal static let title = Strings.tr("Localizable", "AllServices.title", fallback: "All services")
    /// Transfer money
    internal static let transferMoney = Strings.tr("Localizable", "AllServices.transferMoney", fallback: "Transfer money")
  }
  internal enum CardHome {
    /// Cards
    internal static let title = Strings.tr("Localizable", "CardHome.title", fallback: "Cards")
  }
  internal enum Common {
    /// Back
    internal static let back = Strings.tr("Localizable", "Common.back", fallback: "Back")
    /// Close
    internal static let close = Strings.tr("Localizable", "Common.close", fallback: "Close")
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "Common.continueButton", fallback: "Continue")
    /// Failed to submit
    internal static let errorSubmit = Strings.tr("Localizable", "Common.errorSubmit", fallback: "Failed to submit")
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again")
  }
  internal enum HomeApp {
    /// Account terms - Privacy Policy
    internal static let accountTerms = Strings.tr("Localizable", "HomeApp.accountTerms", fallback: "Account terms - Privacy Policy")
    /// Jorge Henrique
    internal static let cardOwnerOne = Strings.tr("Localizable", "HomeApp.cardOwnerOne", fallback: "Jorge Henrique")
    /// Amado Batista
    internal static let cardOwnerTwo = Strings.tr("Localizable", "HomeApp.cardOwnerTwo", fallback: "Amado Batista")
    /// We could not load your cards right now.
    internal static let cardsLoadFailed = Strings.tr("Localizable", "HomeApp.cardsLoadFailed", fallback: "We could not load your cards right now.")
    /// The simulated payments service returned an empty response.
    internal static let emptyDescription = Strings.tr("Localizable", "HomeApp.emptyDescription", fallback: "The simulated payments service returned an empty response.")
    /// We couldn't load your information. Please check your connection and try again.
    internal static let genericErrorDescription = Strings.tr("Localizable", "HomeApp.genericErrorDescription", fallback: "We couldn't load your information. Please check your connection and try again.")
    /// Something went wrong
    internal static let genericErrorTitle = Strings.tr("Localizable", "HomeApp.genericErrorTitle", fallback: "Something went wrong")
    /// Home unavailable
    internal static let homeUnavailableTitle = Strings.tr("Localizable", "HomeApp.homeUnavailableTitle", fallback: "Home unavailable")
    /// Learn More
    internal static let learnMore = Strings.tr("Localizable", "HomeApp.learnMore", fallback: "Learn More")
    /// Logout
    internal static let logout = Strings.tr("Localizable", "HomeApp.logout", fallback: "Logout")
    /// MASTERCARD
    internal static let mastercardBrand = Strings.tr("Localizable", "HomeApp.mastercardBrand", fallback: "MASTERCARD")
    /// Top category: Restaurants 🍔
    internal static let monthlySpendingCaption = Strings.tr("Localizable", "HomeApp.monthlySpendingCaption", fallback: "Top category: Restaurants 🍔")
    /// Monthly Spending
    internal static let monthlySpendingHeadline = Strings.tr("Localizable", "HomeApp.monthlySpendingHeadline", fallback: "Monthly Spending")
    /// You spent $2,310 in August
    internal static let monthlySpendingTitle = Strings.tr("Localizable", "HomeApp.monthlySpendingTitle", fallback: "You spent $2,310 in August")
    /// No dashboard data yet
    internal static let noDashboardDataTitle = Strings.tr("Localizable", "HomeApp.noDashboardDataTitle", fallback: "No dashboard data yet")
    /// @2025 Powered by Blake
    internal static let poweredBy = Strings.tr("Localizable", "HomeApp.poweredBy", fallback: "@2025 Powered by Blake")
    /// See Insights
    internal static let seeInsights = Strings.tr("Localizable", "HomeApp.seeInsights", fallback: "See Insights")
    /// Try later
    internal static let tryLater = Strings.tr("Localizable", "HomeApp.tryLater", fallback: "Try later")
    /// Version 0.00.1
    internal static let version = Strings.tr("Localizable", "HomeApp.version", fallback: "Version 0.00.1")
    /// VISA
    internal static let visaBrand = Strings.tr("Localizable", "HomeApp.visaBrand", fallback: "VISA")
    /// Blake!
    internal static let welcomeName = Strings.tr("Localizable", "HomeApp.welcomeName", fallback: "Blake!")
    /// Welcome, 
    internal static let welcomePrefix = Strings.tr("Localizable", "HomeApp.welcomePrefix", fallback: "Welcome, ")
  }
  internal enum NotificationsCentre {
    /// The simulated service has no notifications to show.
    internal static let emptyDescription = Strings.tr("Localizable", "NotificationsCentre.emptyDescription", fallback: "The simulated service has no notifications to show.")
    /// No notifications yet
    internal static let emptyTitle = Strings.tr("Localizable", "NotificationsCentre.emptyTitle", fallback: "No notifications yet")
    /// Notifications
    internal static let title = Strings.tr("Localizable", "NotificationsCentre.title", fallback: "Notifications")
    /// Notifications unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "NotificationsCentre.unavailableTitle", fallback: "Notifications unavailable")
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
  internal enum Recipients {
    /// New
    /// recipient
    internal static let newRecipient = Strings.tr("Localizable", "Recipients.newRecipient", fallback: "New\nrecipient")
    /// See all
    internal static let seeAll = Strings.tr("Localizable", "Recipients.seeAll", fallback: "See all")
    /// Recipients
    internal static let title = Strings.tr("Localizable", "Recipients.title", fallback: "Recipients")
  }
  internal enum SendMoney {
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "SendMoney.continueButton", fallback: "Continue")
    /// Transfer
    internal static let title = Strings.tr("Localizable", "SendMoney.title", fallback: "Transfer")
  }
  internal enum SpendingChart {
    /// Bills
    internal static let bills = Strings.tr("Localizable", "SpendingChart.bills", fallback: "Bills")
    /// 8.3%
    internal static let change = Strings.tr("Localizable", "SpendingChart.change", fallback: "8.3%")
    /// vs last month
    internal static let comparison = Strings.tr("Localizable", "SpendingChart.comparison", fallback: "vs last month")
    /// Food & Drinks
    internal static let foodAndDrinks = Strings.tr("Localizable", "SpendingChart.foodAndDrinks", fallback: "Food & Drinks")
    /// Shopping
    internal static let shopping = Strings.tr("Localizable", "SpendingChart.shopping", fallback: "Shopping")
    /// Spending this month
    internal static let title = Strings.tr("Localizable", "SpendingChart.title", fallback: "Spending this month")
    /// $ 2,428.00
    internal static let total = Strings.tr("Localizable", "SpendingChart.total", fallback: "$ 2,428.00")
    /// Transport
    internal static let transport = Strings.tr("Localizable", "SpendingChart.transport", fallback: "Transport")
    /// View report
    internal static let viewReport = Strings.tr("Localizable", "SpendingChart.viewReport", fallback: "View report")
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
