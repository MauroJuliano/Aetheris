// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Birthdate {
    /// Enter a valid date in the format DD/MM/YYYY.
    internal static var error: String { Strings.tr("Localizable", "Birthdate.error", fallback: "Enter a valid date in the format DD/MM/YYYY.") }
    /// 26/08/1970
    internal static var placeholder: String { Strings.tr("Localizable", "Birthdate.placeholder", fallback: "26/08/1970") }
    /// We'll use your date of birth to verify your identity securely
    internal static var subTitle: String { Strings.tr("Localizable", "Birthdate.subTitle", fallback: "We'll use your date of birth to verify your identity securely") }
    /// Date of birth
    internal static var title: String { Strings.tr("Localizable", "Birthdate.title", fallback: "Date of birth") }
  }
  internal enum Common {
    /// Failed to submit
    internal static var errorSubmit: String { Strings.tr("Localizable", "Common.errorSubmit", fallback: "Failed to submit") }
  }
  internal enum ConfirmPassword {
    /// 1234
    internal static var placeholder: String { Strings.tr("Localizable", "ConfirmPassword.placeholder", fallback: "1234") }
    /// Re-enter the same 4-digit password to continue.
    internal static var subTitle: String { Strings.tr("Localizable", "ConfirmPassword.subTitle", fallback: "Re-enter the same 4-digit password to continue.") }
    /// Confirm password
    internal static var title: String { Strings.tr("Localizable", "ConfirmPassword.title", fallback: "Confirm password") }
    internal enum Error {
      /// Password does not match.
      internal static var mismatch: String { Strings.tr("Localizable", "ConfirmPassword.error.mismatch", fallback: "Password does not match.") }
      /// Failed to submit
      internal static var submit: String { Strings.tr("Localizable", "ConfirmPassword.error.submit", fallback: "Failed to submit") }
    }
  }
  internal enum Default {
    /// Continue
    internal static var buttonName: String { Strings.tr("Localizable", "Default.buttonName", fallback: "Continue") }
  }
  internal enum Email {
    /// Enter a valid email address.
    internal static var error: String { Strings.tr("Localizable", "Email.error", fallback: "Enter a valid email address.") }
    /// name@example.com
    internal static var placeholder: String { Strings.tr("Localizable", "Email.placeholder", fallback: "name@example.com") }
    /// We'll use this email to identify your account and send important updates.
    internal static var subTitle: String { Strings.tr("Localizable", "Email.subTitle", fallback: "We'll use this email to identify your account and send important updates.") }
    /// Email address
    internal static var title: String { Strings.tr("Localizable", "Email.title", fallback: "Email address") }
  }
  internal enum MothersName {
    /// Enter at least 2 letters.
    internal static var error: String { Strings.tr("Localizable", "MothersName.error", fallback: "Enter at least 2 letters.") }
    /// Enter your mother's full name
    internal static var placeholder: String { Strings.tr("Localizable", "MothersName.placeholder", fallback: "Enter your mother's full name") }
    /// Used as an additional security measure to help protect your account
    internal static var subTitle: String { Strings.tr("Localizable", "MothersName.subTitle", fallback: "Used as an additional security measure to help protect your account") }
    /// Mother's name
    internal static var title: String { Strings.tr("Localizable", "MothersName.title", fallback: "Mother's name") }
  }
  internal enum Onboarding {
    /// Skip
    internal static var skip: String { Strings.tr("Localizable", "Onboarding.skip", fallback: "Skip") }
    /// Continue
    internal static var stepOneButton: String { Strings.tr("Localizable", "Onboarding.stepOneButton", fallback: "Continue") }
    /// Everything you need to manage your money is ready to go.
    internal static var stepOneDescription: String { Strings.tr("Localizable", "Onboarding.stepOneDescription", fallback: "Everything you need to manage your money is ready to go.") }
    /// Your account is ready
    internal static var stepOneTitle: String { Strings.tr("Localizable", "Onboarding.stepOneTitle", fallback: "Your account is ready") }
    /// Get started
    internal static var stepThreeButton: String { Strings.tr("Localizable", "Onboarding.stepThreeButton", fallback: "Get started") }
    /// You are all set to explore Aetheris and use your account.
    internal static var stepThreeDescription: String { Strings.tr("Localizable", "Onboarding.stepThreeDescription", fallback: "You are all set to explore Aetheris and use your account.") }
    /// Ready to start
    internal static var stepThreeTitle: String { Strings.tr("Localizable", "Onboarding.stepThreeTitle", fallback: "Ready to start") }
    /// Continue
    internal static var stepTwoButton: String { Strings.tr("Localizable", "Onboarding.stepTwoButton", fallback: "Continue") }
    /// Track your balance, manage cards and move money with less friction.
    internal static var stepTwoDescription: String { Strings.tr("Localizable", "Onboarding.stepTwoDescription", fallback: "Track your balance, manage cards and move money with less friction.") }
    /// Everything in one place
    internal static var stepTwoTitle: String { Strings.tr("Localizable", "Onboarding.stepTwoTitle", fallback: "Everything in one place") }
  }
  internal enum Password {
    /// Enter a 4-digit password.
    internal static var error: String { Strings.tr("Localizable", "Password.error", fallback: "Enter a 4-digit password.") }
    /// Hide password
    internal static var hide: String { Strings.tr("Localizable", "Password.hide", fallback: "Hide password") }
    /// 1234
    internal static var placeholder: String { Strings.tr("Localizable", "Password.placeholder", fallback: "1234") }
    /// Show password
    internal static var show: String { Strings.tr("Localizable", "Password.show", fallback: "Show password") }
    /// Create a 4-digit numeric password for your account.
    internal static var subTitle: String { Strings.tr("Localizable", "Password.subTitle", fallback: "Create a 4-digit numeric password for your account.") }
    /// Password
    internal static var title: String { Strings.tr("Localizable", "Password.title", fallback: "Password") }
  }
  internal enum Register {
    /// Continue
    internal static var continueButton: String { Strings.tr("Localizable", "Register.continueButton", fallback: "Continue") }
    /// Enter your legal name exactly as it appears on your documents.
    internal static var fullNameSubtitle: String { Strings.tr("Localizable", "Register.fullNameSubtitle", fallback: "Enter your legal name exactly as it appears on your documents.") }
    /// Full name
    internal static var fullNameTitle: String { Strings.tr("Localizable", "Register.fullNameTitle", fallback: "Full name") }
    /// Insert your name
    internal static var placeholderName: String { Strings.tr("Localizable", "Register.placeholderName", fallback: "Insert your name") }
  }
  internal enum Resume {
    /// Continue
    internal static var continueButton: String { Strings.tr("Localizable", "Resume.continueButton", fallback: "Continue") }
    /// Edit
    internal static var edit: String { Strings.tr("Localizable", "Resume.edit", fallback: "Edit") }
    /// Full Name
    internal static var fullName: String { Strings.tr("Localizable", "Resume.fullName", fallback: "Full Name") }
    /// Resume List
    internal static var listTitle: String { Strings.tr("Localizable", "Resume.listTitle", fallback: "Resume List") }
    /// Avenue t's nice to pretend
    internal static var mockAddress: String { Strings.tr("Localizable", "Resume.mockAddress", fallback: "Avenue t's nice to pretend") }
    /// Ann something
    internal static var mockAnnSomething: String { Strings.tr("Localizable", "Resume.mockAnnSomething", fallback: "Ann something") }
    /// 12/10/1980
    internal static var mockBirthDate: String { Strings.tr("Localizable", "Resume.mockBirthDate", fallback: "12/10/1980") }
    /// melissa@example.com
    internal static var mockEmail: String { Strings.tr("Localizable", "Resume.mockEmail", fallback: "melissa@example.com") }
    /// Mystical time
    internal static var mockMysticalTime: String { Strings.tr("Localizable", "Resume.mockMysticalTime", fallback: "Mystical time") }
    /// Melissa Mccarthy
    internal static var mockName: String { Strings.tr("Localizable", "Resume.mockName", fallback: "Melissa Mccarthy") }
    /// 000.000.00-23
    internal static var mockSin: String { Strings.tr("Localizable", "Resume.mockSin", fallback: "000.000.00-23") }
    /// We could never be together
    internal static var mockWeCouldNeverBeTogether: String { Strings.tr("Localizable", "Resume.mockWeCouldNeverBeTogether", fallback: "We could never be together") }
    /// Your information is sent securely only when you continue.
    internal static var securityNote: String { Strings.tr("Localizable", "Resume.securityNote", fallback: "Your information is sent securely only when you continue.") }
    /// Please confirm that all the information below is correct before we continue.
    internal static var subtitle: String { Strings.tr("Localizable", "Resume.subtitle", fallback: "Please confirm that all the information below is correct before we continue.") }
    /// Review You Information
    internal static var title: String { Strings.tr("Localizable", "Resume.title", fallback: "Review You Information") }
  }
  internal enum Sin {
    /// Continue
    internal static var buttonName: String { Strings.tr("Localizable", "SIN.buttonName", fallback: "Continue") }
    /// Enter a valid SIN in the format 000.000.000.
    internal static var error: String { Strings.tr("Localizable", "SIN.error", fallback: "Enter a valid SIN in the format 000.000.000.") }
    /// 000.000.000
    internal static var placeholder: String { Strings.tr("Localizable", "SIN.placeholder", fallback: "000.000.000") }
    /// We'll use your SIN to verify your identity and keep your account secure.
    internal static var subTitle: String { Strings.tr("Localizable", "SIN.subTitle", fallback: "We'll use your SIN to verify your identity and keep your account secure.") }
    /// Social Insurance Number
    internal static var title: String { Strings.tr("Localizable", "SIN.title", fallback: "Social Insurance Number") }
  }
  internal enum SubmissionError {
    /// Cancel
    internal static var cancel: String { Strings.tr("Localizable", "SubmissionError.cancel", fallback: "Cancel") }
    /// We couldn't submit your information. Please try again.
    internal static var description: String { Strings.tr("Localizable", "SubmissionError.description", fallback: "We couldn't submit your information. Please try again.") }
    /// Unable to continue
    internal static var title: String { Strings.tr("Localizable", "SubmissionError.title", fallback: "Unable to continue") }
    /// Try again
    internal static var tryAgain: String { Strings.tr("Localizable", "SubmissionError.tryAgain", fallback: "Try again") }
  }
  internal enum UserName {
    /// Enter at least 2 letters.
    internal static var error: String { Strings.tr("Localizable", "UserName.error", fallback: "Enter at least 2 letters.") }
    /// Enter your full legal name
    internal static var placeholder: String { Strings.tr("Localizable", "UserName.placeholder", fallback: "Enter your full legal name") }
    /// Enter your full name as it appears on your official documents.
    internal static var subTitle: String { Strings.tr("Localizable", "UserName.subTitle", fallback: "Enter your full name as it appears on your official documents.") }
    /// Full name
    internal static var title: String { Strings.tr("Localizable", "UserName.title", fallback: "Full name") }
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
