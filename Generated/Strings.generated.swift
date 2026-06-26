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
