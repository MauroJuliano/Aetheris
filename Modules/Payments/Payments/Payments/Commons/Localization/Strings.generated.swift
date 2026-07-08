// swiftlint:disable all

import Foundation

internal enum Strings {
    internal enum Common {
        internal static let continueButton = Strings.tr("Localizable", "Common.continueButton", fallback: "Continue")
    }

    internal enum SendMoney {
        internal static let title = Strings.tr("Localizable", "SendMoney.title", fallback: "Transfer")
        internal static let continueButton = Strings.tr("Localizable", "SendMoney.continueButton", fallback: "Continue")
    }

    internal enum TransferPin {
        internal static let title = Strings.tr("Localizable", "TransferPin.title", fallback: "Enter your PIN")
        internal static let subtitle = Strings.tr(
            "Localizable",
            "TransferPin.subtitle",
            fallback: "Enter your 4-digit PIN to send\n$250.00 to Melissa Johnson."
        )
        internal static let incorrect = Strings.tr("Localizable", "TransferPin.incorrect", fallback: "Incorrect PIN. Try again.")
        internal static let attempts = Strings.tr("Localizable", "TransferPin.attempts", fallback: "You have %d attempts left.")
        internal static let useFaceID = Strings.tr("Localizable", "TransferPin.useFaceID", fallback: "Use Face ID")
        internal static let confirmTransfer = Strings.tr("Localizable", "TransferPin.confirmTransfer", fallback: "Confirm Transfer")
    }

    internal enum TransferProcessing {
        internal static let title = Strings.tr("Localizable", "TransferProcessing.title", fallback: "Processing transfer...")
        internal static let subtitle = Strings.tr(
            "Localizable",
            "TransferProcessing.subtitle",
            fallback: "Please don't close the app\nor go back."
        )
    }

    internal enum TransferSuccess {
        internal static let title = Strings.tr("Localizable", "TransferSuccess.title", fallback: "Transfer successful!")
        internal static let subtitle = Strings.tr(
            "Localizable",
            "TransferSuccess.subtitle",
            fallback: "Your money has been sent successfully."
        )
        internal static let amount = Strings.tr("Localizable", "TransferSuccess.amount", fallback: "Amount")
        internal static let completed = Strings.tr("Localizable", "TransferSuccess.completed", fallback: "Completed")
        internal static let to = Strings.tr("Localizable", "TransferSuccess.to", fallback: "To")
        internal static let from = Strings.tr("Localizable", "TransferSuccess.from", fallback: "From")
        internal static let dateAndTime = Strings.tr("Localizable", "TransferSuccess.dateAndTime", fallback: "Date & Time")
        internal static let referenceId = Strings.tr("Localizable", "TransferSuccess.referenceId", fallback: "Reference ID")
        internal static let secureTransfer = Strings.tr("Localizable", "TransferSuccess.secureTransfer", fallback: "Secure transfer")
        internal static let secureSubtitle = Strings.tr(
            "Localizable",
            "TransferSuccess.secureSubtitle",
            fallback: "Your transaction is protected and encrypted."
        )
        internal static let done = Strings.tr("Localizable", "TransferSuccess.done", fallback: "Done")
        internal static let anotherTransfer = Strings.tr(
            "Localizable",
            "TransferSuccess.anotherTransfer",
            fallback: "Make another transfer"
        )
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
