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
    /// OK
    internal static var ok: String { Strings.tr("Localizable", "Common.ok", fallback: "OK") }
    /// Try again
    internal static var tryAgain: String { Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again") }
  }
  internal enum Language {
    /// Applying language...
    internal static var applying: String { Strings.tr("Localizable", "Language.applying", fallback: "Applying language...") }
    /// Choose the language you prefer for Aetheris.
    internal static var description: String { Strings.tr("Localizable", "Language.description", fallback: "Choose the language you prefer for Aetheris.") }
    /// English
    internal static var english: String { Strings.tr("Localizable", "Language.english", fallback: "English") }
    /// German
    internal static var german: String { Strings.tr("Localizable", "Language.german", fallback: "German") }
    /// Portuguese
    internal static var portuguese: String { Strings.tr("Localizable", "Language.portuguese", fallback: "Portuguese") }
    /// Selected
    internal static var selected: String { Strings.tr("Localizable", "Language.selected", fallback: "Selected") }
    /// System Default
    internal static var systemDefault: String { Strings.tr("Localizable", "Language.systemDefault", fallback: "System Default") }
    /// Use your device language
    internal static var systemDescription: String { Strings.tr("Localizable", "Language.systemDescription", fallback: "Use your device language") }
    /// Language
    internal static var title: String { Strings.tr("Localizable", "Language.title", fallback: "Language") }
  }
  internal enum Profile {
    /// Confirm logout
    internal static var confirmLogout: String { Strings.tr("Localizable", "Profile.confirmLogout", fallback: "Confirm logout") }
    /// Done
    internal static var done: String { Strings.tr("Localizable", "Profile.done", fallback: "Done") }
    /// Change the email used for notifications and contact.
    internal static var editEmailDescription: String { Strings.tr("Localizable", "Profile.editEmailDescription", fallback: "Change the email used for notifications and contact.") }
    /// Enter email
    internal static var editEmailPlaceholder: String { Strings.tr("Localizable", "Profile.editEmailPlaceholder", fallback: "Enter email") }
    /// Edit email
    internal static var editEmailTitle: String { Strings.tr("Localizable", "Profile.editEmailTitle", fallback: "Edit email") }
    /// Update the public profile name shown in the app.
    internal static var editNameDescription: String { Strings.tr("Localizable", "Profile.editNameDescription", fallback: "Update the public profile name shown in the app.") }
    /// Enter full name
    internal static var editNamePlaceholder: String { Strings.tr("Localizable", "Profile.editNamePlaceholder", fallback: "Enter full name") }
    /// Edit name
    internal static var editNameTitle: String { Strings.tr("Localizable", "Profile.editNameTitle", fallback: "Edit name") }
    /// Update the number associated with the account.
    internal static var editPhoneDescription: String { Strings.tr("Localizable", "Profile.editPhoneDescription", fallback: "Update the number associated with the account.") }
    /// Enter phone number
    internal static var editPhonePlaceholder: String { Strings.tr("Localizable", "Profile.editPhonePlaceholder", fallback: "Enter phone number") }
    /// Edit phone
    internal static var editPhoneTitle: String { Strings.tr("Localizable", "Profile.editPhoneTitle", fallback: "Edit phone") }
    /// blake.lehmann@aetheris.app
    internal static var email: String { Strings.tr("Localizable", "Profile.email", fallback: "blake.lehmann@aetheris.app") }
    /// Tell us what can be improved in the app experience.
    internal static var feedbackDescription: String { Strings.tr("Localizable", "Profile.feedbackDescription", fallback: "Tell us what can be improved in the app experience.") }
    /// Write your feedback here...
    internal static var feedbackPlaceholder: String { Strings.tr("Localizable", "Profile.feedbackPlaceholder", fallback: "Write your feedback here...") }
    /// Feedback
    internal static var feedbackTitle: String { Strings.tr("Localizable", "Profile.feedbackTitle", fallback: "Feedback") }
    /// General
    internal static var generalSection: String { Strings.tr("Localizable", "Profile.generalSection", fallback: "General") }
    /// This legal page keeps the profile flow realistic while remaining fully local to the app.
    internal static var legalDescription: String { Strings.tr("Localizable", "Profile.legalDescription", fallback: "This legal page keeps the profile flow realistic while remaining fully local to the app.") }
    /// Logout
    internal static var logout: String { Strings.tr("Localizable", "Profile.logout", fallback: "Logout") }
    /// This logout action keeps the profile flow realistic while remaining fully local to the app.
    internal static var logoutDescription: String { Strings.tr("Localizable", "Profile.logoutDescription", fallback: "This logout action keeps the profile flow realistic while remaining fully local to the app.") }
    /// Notifications
    internal static var notificationsSection: String { Strings.tr("Localizable", "Profile.notificationsSection", fallback: "Notifications") }
    /// (33) 9908-3213
    internal static var phone: String { Strings.tr("Localizable", "Profile.phone", fallback: "(33) 9908-3213") }
    /// @2025 Powered by Blake
    internal static var poweredBy: String { Strings.tr("Localizable", "Profile.poweredBy", fallback: "@2025 Powered by Blake") }
    /// Privacy Policy
    internal static var privacyPolicy: String { Strings.tr("Localizable", "Profile.privacyPolicy", fallback: "Privacy Policy") }
    /// Push notifications
    internal static var pushNotifications: String { Strings.tr("Localizable", "Profile.pushNotifications", fallback: "Push notifications") }
    /// Some information may be outdated.
    internal static var refreshErrorDescription: String { Strings.tr("Localizable", "Profile.refreshErrorDescription", fallback: "Some information may be outdated.") }
    /// Unable to refresh profile
    internal static var refreshErrorTitle: String { Strings.tr("Localizable", "Profile.refreshErrorTitle", fallback: "Unable to refresh profile") }
    /// Retry
    internal static var retry: String { Strings.tr("Localizable", "Profile.retry", fallback: "Retry") }
    /// Save
    internal static var save: String { Strings.tr("Localizable", "Profile.save", fallback: "Save") }
    /// Send feedback
    internal static var sendFeedback: String { Strings.tr("Localizable", "Profile.sendFeedback", fallback: "Send feedback") }
    /// SMS notifications
    internal static var smsNotifications: String { Strings.tr("Localizable", "Profile.smsNotifications", fallback: "SMS notifications") }
    /// Account terms - Privacy Policy
    internal static var terms: String { Strings.tr("Localizable", "Profile.terms", fallback: "Account terms - Privacy Policy") }
    /// We couldn't update your profile. Please try again.
    internal static var updateErrorDescription: String { Strings.tr("Localizable", "Profile.updateErrorDescription", fallback: "We couldn't update your profile. Please try again.") }
    /// Unable to save changes
    internal static var updateErrorTitle: String { Strings.tr("Localizable", "Profile.updateErrorTitle", fallback: "Unable to save changes") }
    /// Blake Lehmann
    internal static var userName: String { Strings.tr("Localizable", "Profile.userName", fallback: "Blake Lehmann") }
    /// Version 0.00.1
    internal static var version: String { Strings.tr("Localizable", "Profile.version", fallback: "Version 0.00.1") }
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
