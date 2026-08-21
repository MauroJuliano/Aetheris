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
    internal static let back = Strings.tr("Localizable", "Common.back", fallback: "Back")
    /// OK
    internal static let ok = Strings.tr("Localizable", "Common.ok", fallback: "OK")
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again")
  }
  internal enum Language {
    /// Choose the language you prefer for Aetheris.
    internal static let description = Strings.tr("Localizable", "Language.description", fallback: "Choose the language you prefer for Aetheris.")
    /// English
    internal static let english = Strings.tr("Localizable", "Language.english", fallback: "English")
    /// German
    internal static let german = Strings.tr("Localizable", "Language.german", fallback: "German")
    /// Portuguese
    internal static let portuguese = Strings.tr("Localizable", "Language.portuguese", fallback: "Portuguese")
    /// The new language will be applied the next time you open Aetheris.
    internal static let restartDescription = Strings.tr("Localizable", "Language.restartDescription", fallback: "The new language will be applied the next time you open Aetheris.")
    /// Language saved
    internal static let restartTitle = Strings.tr("Localizable", "Language.restartTitle", fallback: "Language saved")
    /// Selected
    internal static let selected = Strings.tr("Localizable", "Language.selected", fallback: "Selected")
    /// System Default
    internal static let systemDefault = Strings.tr("Localizable", "Language.systemDefault", fallback: "System Default")
    /// Use your device language
    internal static let systemDescription = Strings.tr("Localizable", "Language.systemDescription", fallback: "Use your device language")
    /// Language
    internal static let title = Strings.tr("Localizable", "Language.title", fallback: "Language")
  }
  internal enum Profile {
    /// Confirm logout
    internal static let confirmLogout = Strings.tr("Localizable", "Profile.confirmLogout", fallback: "Confirm logout")
    /// Done
    internal static let done = Strings.tr("Localizable", "Profile.done", fallback: "Done")
    /// Change the email used for notifications and contact.
    internal static let editEmailDescription = Strings.tr("Localizable", "Profile.editEmailDescription", fallback: "Change the email used for notifications and contact.")
    /// Enter email
    internal static let editEmailPlaceholder = Strings.tr("Localizable", "Profile.editEmailPlaceholder", fallback: "Enter email")
    /// Edit email
    internal static let editEmailTitle = Strings.tr("Localizable", "Profile.editEmailTitle", fallback: "Edit email")
    /// Update the public profile name shown in the app.
    internal static let editNameDescription = Strings.tr("Localizable", "Profile.editNameDescription", fallback: "Update the public profile name shown in the app.")
    /// Enter full name
    internal static let editNamePlaceholder = Strings.tr("Localizable", "Profile.editNamePlaceholder", fallback: "Enter full name")
    /// Edit name
    internal static let editNameTitle = Strings.tr("Localizable", "Profile.editNameTitle", fallback: "Edit name")
    /// Update the number associated with the account.
    internal static let editPhoneDescription = Strings.tr("Localizable", "Profile.editPhoneDescription", fallback: "Update the number associated with the account.")
    /// Enter phone number
    internal static let editPhonePlaceholder = Strings.tr("Localizable", "Profile.editPhonePlaceholder", fallback: "Enter phone number")
    /// Edit phone
    internal static let editPhoneTitle = Strings.tr("Localizable", "Profile.editPhoneTitle", fallback: "Edit phone")
    /// blake.lehmann@aetheris.app
    internal static let email = Strings.tr("Localizable", "Profile.email", fallback: "blake.lehmann@aetheris.app")
    /// Tell us what can be improved in the app experience.
    internal static let feedbackDescription = Strings.tr("Localizable", "Profile.feedbackDescription", fallback: "Tell us what can be improved in the app experience.")
    /// Write your feedback here...
    internal static let feedbackPlaceholder = Strings.tr("Localizable", "Profile.feedbackPlaceholder", fallback: "Write your feedback here...")
    /// Feedback
    internal static let feedbackTitle = Strings.tr("Localizable", "Profile.feedbackTitle", fallback: "Feedback")
    /// General
    internal static let generalSection = Strings.tr("Localizable", "Profile.generalSection", fallback: "General")
    /// This legal page keeps the profile flow realistic while remaining fully local to the app.
    internal static let legalDescription = Strings.tr("Localizable", "Profile.legalDescription", fallback: "This legal page keeps the profile flow realistic while remaining fully local to the app.")
    /// Logout
    internal static let logout = Strings.tr("Localizable", "Profile.logout", fallback: "Logout")
    /// This logout action keeps the profile flow realistic while remaining fully local to the app.
    internal static let logoutDescription = Strings.tr("Localizable", "Profile.logoutDescription", fallback: "This logout action keeps the profile flow realistic while remaining fully local to the app.")
    /// Notifications
    internal static let notificationsSection = Strings.tr("Localizable", "Profile.notificationsSection", fallback: "Notifications")
    /// (33) 9908-3213
    internal static let phone = Strings.tr("Localizable", "Profile.phone", fallback: "(33) 9908-3213")
    /// @2025 Powered by Blake
    internal static let poweredBy = Strings.tr("Localizable", "Profile.poweredBy", fallback: "@2025 Powered by Blake")
    /// Privacy Policy
    internal static let privacyPolicy = Strings.tr("Localizable", "Profile.privacyPolicy", fallback: "Privacy Policy")
    /// Push notifications
    internal static let pushNotifications = Strings.tr("Localizable", "Profile.pushNotifications", fallback: "Push notifications")
    /// Some information may be outdated.
    internal static let refreshErrorDescription = Strings.tr("Localizable", "Profile.refreshErrorDescription", fallback: "Some information may be outdated.")
    /// Unable to refresh profile
    internal static let refreshErrorTitle = Strings.tr("Localizable", "Profile.refreshErrorTitle", fallback: "Unable to refresh profile")
    /// Retry
    internal static let retry = Strings.tr("Localizable", "Profile.retry", fallback: "Retry")
    /// Save
    internal static let save = Strings.tr("Localizable", "Profile.save", fallback: "Save")
    /// Send feedback
    internal static let sendFeedback = Strings.tr("Localizable", "Profile.sendFeedback", fallback: "Send feedback")
    /// SMS notifications
    internal static let smsNotifications = Strings.tr("Localizable", "Profile.smsNotifications", fallback: "SMS notifications")
    /// Account terms - Privacy Policy
    internal static let terms = Strings.tr("Localizable", "Profile.terms", fallback: "Account terms - Privacy Policy")
    /// We couldn't update your profile. Please try again.
    internal static let updateErrorDescription = Strings.tr("Localizable", "Profile.updateErrorDescription", fallback: "We couldn't update your profile. Please try again.")
    /// Unable to save changes
    internal static let updateErrorTitle = Strings.tr("Localizable", "Profile.updateErrorTitle", fallback: "Unable to save changes")
    /// Blake Lehmann
    internal static let userName = Strings.tr("Localizable", "Profile.userName", fallback: "Blake Lehmann")
    /// Version 0.00.1
    internal static let version = Strings.tr("Localizable", "Profile.version", fallback: "Version 0.00.1")
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
