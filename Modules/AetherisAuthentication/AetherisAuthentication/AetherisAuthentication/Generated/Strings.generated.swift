// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum ForgotPassword {
    /// Back
    internal static var back: String { Strings.tr("Localizable", "ForgotPassword.back", fallback: "Back") }
    /// Back to login
    internal static var backToLogin: String { Strings.tr("Localizable", "ForgotPassword.backToLogin", fallback: "Back to login") }
    /// Enter your email and we'll send you a link to reset your password.
    internal static var description: String { Strings.tr("Localizable", "ForgotPassword.description", fallback: "Enter your email and we'll send you a link to reset your password.") }
    /// Email address
    internal static var emailLabel: String { Strings.tr("Localizable", "ForgotPassword.emailLabel", fallback: "Email address") }
    /// Enter your email
    internal static var emailPlaceholder: String { Strings.tr("Localizable", "ForgotPassword.emailPlaceholder", fallback: "Enter your email") }
    /// No worries!
    internal static var heading: String { Strings.tr("Localizable", "ForgotPassword.heading", fallback: "No worries!") }
    /// Remember your password?
    internal static var rememberPassword: String { Strings.tr("Localizable", "ForgotPassword.rememberPassword", fallback: "Remember your password?") }
    /// Send reset link
    internal static var sendResetLink: String { Strings.tr("Localizable", "ForgotPassword.sendResetLink", fallback: "Send reset link") }
    /// Forgot password?
    internal static var title: String { Strings.tr("Localizable", "ForgotPassword.title", fallback: "Forgot password?") }
  }
  internal enum IdentityValidation {
    /// Close
    internal static var close: String { Strings.tr("Localizable", "IdentityValidation.close", fallback: "Close") }
    /// The PIN could not be validated. Please review it and start again.
    internal static var errorDescription: String { Strings.tr("Localizable", "IdentityValidation.errorDescription", fallback: "The PIN could not be validated. Please review it and start again.") }
    /// We couldn't confirm your identity
    internal static var errorTitle: String { Strings.tr("Localizable", "IdentityValidation.errorTitle", fallback: "We couldn't confirm your identity") }
  }
  internal enum Login {
    /// Don't have an account?
    internal static var dontHaveAccount: String { Strings.tr("Localizable", "Login.dontHaveAccount", fallback: "Don't have an account?") }
    /// Enter your email
    internal static var emailPlaceholder: String { Strings.tr("Localizable", "Login.emailPlaceholder", fallback: "Enter your email") }
    /// Let's get started
    internal static var getStarted: String { Strings.tr("Localizable", "Login.getStarted", fallback: "Let's get started") }
    /// Your financial journey continues. 
    /// Let’s make your next 
    /// move count.
    internal static var journey: String { Strings.tr("Localizable", "Login.journey", fallback: "Your financial journey continues. \nLet’s make your next \nmove count.") }
    /// Login
    internal static var loginButton: String { Strings.tr("Localizable", "Login.loginButton", fallback: "Login") }
    /// Enter your password
    internal static var passwordPlaceholder: String { Strings.tr("Localizable", "Login.passwordPlaceholder", fallback: "Enter your password") }
    /// Sign up here
    internal static var signUp: String { Strings.tr("Localizable", "Login.signUp", fallback: "Sign up here") }
    /// Welcome back!
    internal static var welcomeBack: String { Strings.tr("Localizable", "Login.welcomeBack", fallback: "Welcome back!") }
  }
  internal enum LoginError {
    /// The username or password you entered is incorrect. Please check your credentials and try again.
    internal static var description: String { Strings.tr("Localizable", "LoginError.description", fallback: "The username or password you entered is incorrect. Please check your credentials and try again.") }
    /// Try again
    internal static var primaryButton: String { Strings.tr("Localizable", "LoginError.primaryButton", fallback: "Try again") }
    /// Forgot password?
    internal static var secondaryButton: String { Strings.tr("Localizable", "LoginError.secondaryButton", fallback: "Forgot password?") }
    /// Unable to sign in
    internal static var title: String { Strings.tr("Localizable", "LoginError.title", fallback: "Unable to sign in") }
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
