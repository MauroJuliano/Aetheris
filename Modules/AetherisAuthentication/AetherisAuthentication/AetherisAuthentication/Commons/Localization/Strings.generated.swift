// swiftlint:disable all

import Foundation

internal enum Strings {
    internal enum Login {
        internal static let welcomeBack = Strings.tr("Localizable", "Login.welcomeBack", fallback: "Welcome back!")
        internal static let getStarted = Strings.tr("Localizable", "Login.getStarted", fallback: "Let's get started")
        internal static let journey = Strings.tr(
            "Localizable",
            "Login.journey",
            fallback: "Your financial journey continues. \nLet’s make your next \nmove count."
        )
        internal static let emailPlaceholder = Strings.tr("Localizable", "Login.emailPlaceholder", fallback: "Enter your email")
        internal static let passwordPlaceholder = Strings.tr("Localizable", "Login.passwordPlaceholder", fallback: "Enter your password")
        internal static let loginButton = Strings.tr("Localizable", "Login.loginButton", fallback: "Login")
        internal static let dontHaveAccount = Strings.tr("Localizable", "Login.dontHaveAccount", fallback: "Don't have an account?")
        internal static let signUp = Strings.tr("Localizable", "Login.signUp", fallback: "Sign up here")
    }

    private static func tr(_ table: String, _ key: String, fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return format
    }
}

private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}
