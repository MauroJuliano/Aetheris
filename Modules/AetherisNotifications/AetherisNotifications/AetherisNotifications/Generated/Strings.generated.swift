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
  internal enum Notifications {
    /// %d days ago
    internal static func daysAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "Notifications.daysAgo", p1, fallback: "%d days ago")
    }
    /// %d months ago
    internal static func monthsAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "Notifications.monthsAgo", p1, fallback: "%d months ago")
    }
    /// 1 day ago
    internal static var oneDayAgo: String { Strings.tr("Localizable", "Notifications.oneDayAgo", fallback: "1 day ago") }
    /// 1 month ago
    internal static var oneMonthAgo: String { Strings.tr("Localizable", "Notifications.oneMonthAgo", fallback: "1 month ago") }
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
    /// System maintenance completed
    internal static var titleMaintenanceCompleted: String { Strings.tr("Localizable", "Notifications.titleMaintenanceCompleted", fallback: "System maintenance completed") }
    /// Payment received from Amelia Thompson
    internal static var titlePaymentReceived: String { Strings.tr("Localizable", "Notifications.titlePaymentReceived", fallback: "Payment received from Amelia Thompson") }
    /// Refund processed successfully
    internal static var titleRefundProcessed: String { Strings.tr("Localizable", "Notifications.titleRefundProcessed", fallback: "Refund processed successfully") }
    /// Your subscription has expired
    internal static var titleSubscriptionExpired: String { Strings.tr("Localizable", "Notifications.titleSubscriptionExpired", fallback: "Your subscription has expired") }
    /// Subscription renewed for Man's best Friend
    internal static var titleSubscriptionRenewed: String { Strings.tr("Localizable", "Notifications.titleSubscriptionRenewed", fallback: "Subscription renewed for Man's best Friend") }
    /// Funds successfully transferred to Sophie Keller
    internal static var titleTransferSent: String { Strings.tr("Localizable", "Notifications.titleTransferSent", fallback: "Funds successfully transferred to Sophie Keller") }
  }
  internal enum NotificationsCentre {
    /// The simulated service has no notifications to show.
    internal static var emptyDescription: String { Strings.tr("Localizable", "NotificationsCentre.emptyDescription", fallback: "The simulated service has no notifications to show.") }
    /// No notifications yet
    internal static var emptyTitle: String { Strings.tr("Localizable", "NotificationsCentre.emptyTitle", fallback: "No notifications yet") }
    /// Notifications
    internal static var title: String { Strings.tr("Localizable", "NotificationsCentre.title", fallback: "Notifications") }
    /// Notifications unavailable
    internal static var unavailableTitle: String { Strings.tr("Localizable", "NotificationsCentre.unavailableTitle", fallback: "Notifications unavailable") }
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
