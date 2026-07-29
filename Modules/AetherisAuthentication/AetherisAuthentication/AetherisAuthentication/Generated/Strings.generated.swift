// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Login {
    /// Don't have an account?
    internal static let dontHaveAccount = Strings.tr("Localizable", "Login.dontHaveAccount", fallback: "Don't have an account?")
    /// Enter your email
    internal static let emailPlaceholder = Strings.tr("Localizable", "Login.emailPlaceholder", fallback: "Enter your email")
    /// Let's get started
    internal static let getStarted = Strings.tr("Localizable", "Login.getStarted", fallback: "Let's get started")
    /// Your financial journey continues. 
    /// Let’s make your next 
    /// move count.
    internal static let journey = Strings.tr("Localizable", "Login.journey", fallback: "Your financial journey continues. \nLet’s make your next \nmove count.")
    /// Login
    internal static let loginButton = Strings.tr("Localizable", "Login.loginButton", fallback: "Login")
    /// Enter your password
    internal static let passwordPlaceholder = Strings.tr("Localizable", "Login.passwordPlaceholder", fallback: "Enter your password")
    /// Sign up here
    internal static let signUp = Strings.tr("Localizable", "Login.signUp", fallback: "Sign up here")
    /// Welcome back!
    internal static let welcomeBack = Strings.tr("Localizable", "Login.welcomeBack", fallback: "Welcome back!")
  }
  internal enum LoginError {
    /// The username or password you entered is incorrect. Please check your credentials and try again.
    internal static let description = Strings.tr("Localizable", "LoginError.description", fallback: "The username or password you entered is incorrect. Please check your credentials and try again.")
    /// Try again
    internal static let primaryButton = Strings.tr("Localizable", "LoginError.primaryButton", fallback: "Try again")
    /// Forgot password?
    internal static let secondaryButton = Strings.tr("Localizable", "LoginError.secondaryButton", fallback: "Forgot password?")
    /// Unable to sign in
    internal static let title = Strings.tr("Localizable", "LoginError.title", fallback: "Unable to sign in")
  }
  internal enum ForgotPassword {
    /// Back
    internal static let back = Strings.tr("Localizable", "ForgotPassword.back", fallback: "Back")
    /// Back to login
    internal static let backToLogin = Strings.tr("Localizable", "ForgotPassword.backToLogin", fallback: "Back to login")
    /// Enter your email and we'll send you a link to reset your password.
    internal static let description = Strings.tr("Localizable", "ForgotPassword.description", fallback: "Enter your email and we'll send you a link to reset your password.")
    /// Email address
    internal static let emailLabel = Strings.tr("Localizable", "ForgotPassword.emailLabel", fallback: "Email address")
    /// Enter your email
    internal static let emailPlaceholder = Strings.tr("Localizable", "ForgotPassword.emailPlaceholder", fallback: "Enter your email")
    /// No worries!
    internal static let heading = Strings.tr("Localizable", "ForgotPassword.heading", fallback: "No worries!")
    /// Remember your password?
    internal static let rememberPassword = Strings.tr("Localizable", "ForgotPassword.rememberPassword", fallback: "Remember your password?")
    /// Send reset link
    internal static let sendResetLink = Strings.tr("Localizable", "ForgotPassword.sendResetLink", fallback: "Send reset link")
    /// Forgot password?
    internal static let title = Strings.tr("Localizable", "ForgotPassword.title", fallback: "Forgot password?")
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
