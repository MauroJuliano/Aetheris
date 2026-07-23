// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Birthdate {
    /// 26/08/1970
    internal static let placeholder = Strings.tr("Localizable", "Birthdate.placeholder", fallback: "26/08/1970")
    /// We'll use your date of birth to verify your identity securely
    internal static let subTitle = Strings.tr("Localizable", "Birthdate.subTitle", fallback: "We'll use your date of birth to verify your identity securely")
    /// Date of birth
    internal static let title = Strings.tr("Localizable", "Birthdate.title", fallback: "Date of birth")
  }
  internal enum Default {
    /// Continue
    internal static let buttonName = Strings.tr("Localizable", "Default.buttonName", fallback: "Continue")
  }
  internal enum MothersName {
    /// Jane doe
    internal static let placeholder = Strings.tr("Localizable", "MothersName.placeholder", fallback: "Jane doe")
    /// Mother's name
    internal static let title = Strings.tr("Localizable", "MothersName.title", fallback: "Mother's name")
  }
  internal enum Register {
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "Register.continueButton", fallback: "Continue")
    /// Enter your legal name exactly as it appears on your documents.
    internal static let fullNameSubtitle = Strings.tr("Localizable", "Register.fullNameSubtitle", fallback: "Enter your legal name exactly as it appears on your documents.")
    /// Full name
    internal static let fullNameTitle = Strings.tr("Localizable", "Register.fullNameTitle", fallback: "Full name")
    /// Insert your name
    internal static let placeholderName = Strings.tr("Localizable", "Register.placeholderName", fallback: "Insert your name")
  }
  internal enum Resume {
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "Resume.continueButton", fallback: "Continue")
    /// Edit
    internal static let edit = Strings.tr("Localizable", "Resume.edit", fallback: "Edit")
    /// Full Name
    internal static let fullName = Strings.tr("Localizable", "Resume.fullName", fallback: "Full Name")
    /// Resume List
    internal static let listTitle = Strings.tr("Localizable", "Resume.listTitle", fallback: "Resume List")
    /// Avenue t's nice to pretend
    internal static let mockAddress = Strings.tr("Localizable", "Resume.mockAddress", fallback: "Avenue t's nice to pretend")
    /// Ann something
    internal static let mockAnnSomething = Strings.tr("Localizable", "Resume.mockAnnSomething", fallback: "Ann something")
    /// 12/10/1980
    internal static let mockBirthDate = Strings.tr("Localizable", "Resume.mockBirthDate", fallback: "12/10/1980")
    /// Mystical time
    internal static let mockMysticalTime = Strings.tr("Localizable", "Resume.mockMysticalTime", fallback: "Mystical time")
    /// Melissa Mccarthy
    internal static let mockName = Strings.tr("Localizable", "Resume.mockName", fallback: "Melissa Mccarthy")
    /// 000.000.00-23
    internal static let mockSin = Strings.tr("Localizable", "Resume.mockSin", fallback: "000.000.00-23")
    /// We could never be together
    internal static let mockWeCouldNeverBeTogether = Strings.tr("Localizable", "Resume.mockWeCouldNeverBeTogether", fallback: "We could never be together")
    /// Your information is securely encrypted and will never be shared.
    internal static let securityNote = Strings.tr("Localizable", "Resume.securityNote", fallback: "Your information is securely encrypted and will never be shared.")
    /// Please confirm that all the information below is correct before we continue.
    internal static let subtitle = Strings.tr("Localizable", "Resume.subtitle", fallback: "Please confirm that all the information below is correct before we continue.")
    /// Review You Information
    internal static let title = Strings.tr("Localizable", "Resume.title", fallback: "Review You Information")
  }
  internal enum Sin {
    /// Continue
    internal static let buttonName = Strings.tr("Localizable", "SIN.buttonName", fallback: "Continue")
    /// 000.000.000
    internal static let placeholder = Strings.tr("Localizable", "SIN.placeholder", fallback: "000.000.000")
    /// We'll use your SIN to verify your identity and keep your account secure.
    internal static let subTitle = Strings.tr("Localizable", "SIN.subTitle", fallback: "We'll use your SIN to verify your identity and keep your account secure.")
    /// Social Insurance Number
    internal static let title = Strings.tr("Localizable", "SIN.title", fallback: "Social Insurance Number")
  }
  internal enum UserName {
    /// John doe
    internal static let placeholder = Strings.tr("Localizable", "UserName.placeholder", fallback: "John doe")
    /// Choose a unique username that others can use to find and pay you.
    internal static let subTitle = Strings.tr("Localizable", "UserName.subTitle", fallback: "Choose a unique username that others can use to find and pay you.")
    /// Full name
    internal static let title = Strings.tr("Localizable", "UserName.title", fallback: "Full name")
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
