// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Common {
    /// Back
    internal static var back: String { Strings.tr("Localizable", "Common.back", fallback: "Back") }
    /// Close
    internal static var close: String { Strings.tr("Localizable", "Common.close", fallback: "Close") }
    /// Continue
    internal static var continueButton: String { Strings.tr("Localizable", "Common.continueButton", fallback: "Continue") }
    /// Failed to submit
    internal static var errorSubmit: String { Strings.tr("Localizable", "Common.errorSubmit", fallback: "Failed to submit") }
    /// Try again
    internal static var tryAgain: String { Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again") }
  }
  internal enum HomeApp {
    /// Account terms - Privacy Policy
    internal static var accountTerms: String { Strings.tr("Localizable", "HomeApp.accountTerms", fallback: "Account terms - Privacy Policy") }
    /// Jorge Henrique
    internal static var cardOwnerOne: String { Strings.tr("Localizable", "HomeApp.cardOwnerOne", fallback: "Jorge Henrique") }
    /// Amado Batista
    internal static var cardOwnerTwo: String { Strings.tr("Localizable", "HomeApp.cardOwnerTwo", fallback: "Amado Batista") }
    /// We could not load your cards right now.
    internal static var cardsLoadFailed: String { Strings.tr("Localizable", "HomeApp.cardsLoadFailed", fallback: "We could not load your cards right now.") }
    /// The simulated payments service returned an empty response.
    internal static var emptyDescription: String { Strings.tr("Localizable", "HomeApp.emptyDescription", fallback: "The simulated payments service returned an empty response.") }
    /// We couldn't load your information. Please check your connection and try again.
    internal static var genericErrorDescription: String { Strings.tr("Localizable", "HomeApp.genericErrorDescription", fallback: "We couldn't load your information. Please check your connection and try again.") }
    /// Something went wrong
    internal static var genericErrorTitle: String { Strings.tr("Localizable", "HomeApp.genericErrorTitle", fallback: "Something went wrong") }
    /// Home unavailable
    internal static var homeUnavailableTitle: String { Strings.tr("Localizable", "HomeApp.homeUnavailableTitle", fallback: "Home unavailable") }
    /// Learn More
    internal static var learnMore: String { Strings.tr("Localizable", "HomeApp.learnMore", fallback: "Learn More") }
    /// Logout
    internal static var logout: String { Strings.tr("Localizable", "HomeApp.logout", fallback: "Logout") }
    /// MASTERCARD
    internal static var mastercardBrand: String { Strings.tr("Localizable", "HomeApp.mastercardBrand", fallback: "MASTERCARD") }
    /// Top category: Restaurants 🍔
    internal static var monthlySpendingCaption: String { Strings.tr("Localizable", "HomeApp.monthlySpendingCaption", fallback: "Top category: Restaurants 🍔") }
    /// Monthly Spending
    internal static var monthlySpendingHeadline: String { Strings.tr("Localizable", "HomeApp.monthlySpendingHeadline", fallback: "Monthly Spending") }
    /// You spent $2,310 in August
    internal static var monthlySpendingTitle: String { Strings.tr("Localizable", "HomeApp.monthlySpendingTitle", fallback: "You spent $2,310 in August") }
    /// No dashboard data yet
    internal static var noDashboardDataTitle: String { Strings.tr("Localizable", "HomeApp.noDashboardDataTitle", fallback: "No dashboard data yet") }
    /// @2025 Powered by Blake
    internal static var poweredBy: String { Strings.tr("Localizable", "HomeApp.poweredBy", fallback: "@2025 Powered by Blake") }
    /// See Insights
    internal static var seeInsights: String { Strings.tr("Localizable", "HomeApp.seeInsights", fallback: "See Insights") }
    /// Try later
    internal static var tryLater: String { Strings.tr("Localizable", "HomeApp.tryLater", fallback: "Try later") }
    /// Version 0.00.1
    internal static var version: String { Strings.tr("Localizable", "HomeApp.version", fallback: "Version 0.00.1") }
    /// VISA
    internal static var visaBrand: String { Strings.tr("Localizable", "HomeApp.visaBrand", fallback: "VISA") }
    /// Blake!
    internal static var welcomeName: String { Strings.tr("Localizable", "HomeApp.welcomeName", fallback: "Blake!") }
    /// Welcome, 
    internal static var welcomePrefix: String { Strings.tr("Localizable", "HomeApp.welcomePrefix", fallback: "Welcome, ") }
  }
  internal enum SpendingChart {
    /// Bills
    internal static var bills: String { Strings.tr("Localizable", "SpendingChart.bills", fallback: "Bills") }
    /// 8.3%
    internal static var change: String { Strings.tr("Localizable", "SpendingChart.change", fallback: "8.3%") }
    /// vs last month
    internal static var comparison: String { Strings.tr("Localizable", "SpendingChart.comparison", fallback: "vs last month") }
    /// Food & Drinks
    internal static var foodAndDrinks: String { Strings.tr("Localizable", "SpendingChart.foodAndDrinks", fallback: "Food & Drinks") }
    /// Shopping
    internal static var shopping: String { Strings.tr("Localizable", "SpendingChart.shopping", fallback: "Shopping") }
    /// Spending this month
    internal static var title: String { Strings.tr("Localizable", "SpendingChart.title", fallback: "Spending this month") }
    /// $ 2,428.00
    internal static var total: String { Strings.tr("Localizable", "SpendingChart.total", fallback: "$ 2,428.00") }
    /// Transport
    internal static var transport: String { Strings.tr("Localizable", "SpendingChart.transport", fallback: "Transport") }
    /// View report
    internal static var viewReport: String { Strings.tr("Localizable", "SpendingChart.viewReport", fallback: "View report") }
  }
  internal enum ViewReport {
    /// View Report
    internal static var loadingTitle: String { Strings.tr("Localizable", "ViewReport.loadingTitle", fallback: "View Report") }
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
