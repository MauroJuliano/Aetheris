// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum BeneficiaryAdd {
    /// Enter the email or PIX key for the person you want to find.
    internal static var description: String { Strings.tr("Localizable", "BeneficiaryAdd.description", fallback: "Enter the email or PIX key for the person you want to find.") }
    /// Enter an email or PIX key to continue.
    internal static var invalidSearch: String { Strings.tr("Localizable", "BeneficiaryAdd.invalidSearch", fallback: "Enter an email or PIX key to continue.") }
    /// Find beneficiary
    internal static var searchButton: String { Strings.tr("Localizable", "BeneficiaryAdd.searchButton", fallback: "Find beneficiary") }
    /// We could not find this beneficiary right now.
    internal static var searchFailed: String { Strings.tr("Localizable", "BeneficiaryAdd.searchFailed", fallback: "We could not find this beneficiary right now.") }
    /// Searching...
    internal static var searching: String { Strings.tr("Localizable", "BeneficiaryAdd.searching", fallback: "Searching...") }
    /// Email or PIX key
    internal static var searchLabel: String { Strings.tr("Localizable", "BeneficiaryAdd.searchLabel", fallback: "Email or PIX key") }
    /// Enter email or PIX key
    internal static var searchPlaceholder: String { Strings.tr("Localizable", "BeneficiaryAdd.searchPlaceholder", fallback: "Enter email or PIX key") }
    /// Search an existing recipient to use in this transfer.
    internal static var subtitle: String { Strings.tr("Localizable", "BeneficiaryAdd.subtitle", fallback: "Search an existing recipient to use in this transfer.") }
    /// Find beneficiary
    internal static var title: String { Strings.tr("Localizable", "BeneficiaryAdd.title", fallback: "Find beneficiary") }
  }
  internal enum BeneficiaryDetails {
    /// Account
    internal static var account: String { Strings.tr("Localizable", "BeneficiaryDetails.account", fallback: "Account") }
    /// Something went wrong
    internal static var actionErrorTitle: String { Strings.tr("Localizable", "BeneficiaryDetails.actionErrorTitle", fallback: "Something went wrong") }
    /// Bank account
    internal static var bankAccount: String { Strings.tr("Localizable", "BeneficiaryDetails.bankAccount", fallback: "Bank account") }
    /// Business
    internal static var business: String { Strings.tr("Localizable", "BeneficiaryDetails.business", fallback: "Business") }
    /// Completed
    internal static var completed: String { Strings.tr("Localizable", "BeneficiaryDetails.completed", fallback: "Completed") }
    /// Concert ticket
    internal static var concertTicket: String { Strings.tr("Localizable", "BeneficiaryDetails.concertTicket", fallback: "Concert ticket") }
    /// Contact
    internal static var contact: String { Strings.tr("Localizable", "BeneficiaryDetails.contact", fallback: "Contact") }
    /// Dinner with %@
    internal static func dinnerWith(_ p1: Any) -> String {
      return Strings.tr("Localizable", "BeneficiaryDetails.dinnerWith", String(describing: p1), fallback: "Dinner with %@")
    }
    /// Email
    internal static var email: String { Strings.tr("Localizable", "BeneficiaryDetails.email", fallback: "Email") }
    /// We couldn't find the details for this beneficiary.
    internal static var emptyDescription: String { Strings.tr("Localizable", "BeneficiaryDetails.emptyDescription", fallback: "We couldn't find the details for this beneficiary.") }
    /// Beneficiary not found
    internal static var emptyTitle: String { Strings.tr("Localizable", "BeneficiaryDetails.emptyTitle", fallback: "Beneficiary not found") }
    /// Failed
    internal static var failed: String { Strings.tr("Localizable", "BeneficiaryDetails.failed", fallback: "Failed") }
    /// Information
    internal static var information: String { Strings.tr("Localizable", "BeneficiaryDetails.information", fallback: "Information") }
    /// Location
    internal static var location: String { Strings.tr("Localizable", "BeneficiaryDetails.location", fallback: "Location") }
    /// More
    internal static var more: String { Strings.tr("Localizable", "BeneficiaryDetails.more", fallback: "More") }
    /// Net
    internal static var net: String { Strings.tr("Localizable", "BeneficiaryDetails.net", fallback: "Net") }
    /// 1 transaction
    internal static var oneTransaction: String { Strings.tr("Localizable", "BeneficiaryDetails.oneTransaction", fallback: "1 transaction") }
    /// Payment received
    internal static var paymentReceived: String { Strings.tr("Localizable", "BeneficiaryDetails.paymentReceived", fallback: "Payment received") }
    /// Pending
    internal static var pending: String { Strings.tr("Localizable", "BeneficiaryDetails.pending", fallback: "Pending") }
    /// Phone
    internal static var phone: String { Strings.tr("Localizable", "BeneficiaryDetails.phone", fallback: "Phone") }
    /// Received
    internal static var received: String { Strings.tr("Localizable", "BeneficiaryDetails.received", fallback: "Received") }
    /// Remove beneficiary
    internal static var removeBeneficiary: String { Strings.tr("Localizable", "BeneficiaryDetails.removeBeneficiary", fallback: "Remove beneficiary") }
    /// You will no longer be able to send or request money from this person.
    internal static var removeBeneficiaryDescription: String { Strings.tr("Localizable", "BeneficiaryDetails.removeBeneficiaryDescription", fallback: "You will no longer be able to send or request money from this person.") }
    /// This person will be removed from your beneficiaries. Your transaction history will not be deleted.
    internal static var removeConfirmationDescription: String { Strings.tr("Localizable", "BeneficiaryDetails.removeConfirmationDescription", fallback: "This person will be removed from your beneficiaries. Your transaction history will not be deleted.") }
    /// Remove this beneficiary?
    internal static var removeConfirmationTitle: String { Strings.tr("Localizable", "BeneficiaryDetails.removeConfirmationTitle", fallback: "Remove this beneficiary?") }
    /// Request
    internal static var request: String { Strings.tr("Localizable", "BeneficiaryDetails.request", fallback: "Request") }
    /// Sent
    internal static var sent: String { Strings.tr("Localizable", "BeneficiaryDetails.sent", fallback: "Sent") }
    /// Thanks for the collaboration
    internal static var thanksForCollaboration: String { Strings.tr("Localizable", "BeneficiaryDetails.thanksForCollaboration", fallback: "Thanks for the collaboration") }
    /// Beneficiary
    internal static var title: String { Strings.tr("Localizable", "BeneficiaryDetails.title", fallback: "Beneficiary") }
    /// Transactions
    internal static var transactions: String { Strings.tr("Localizable", "BeneficiaryDetails.transactions", fallback: "Transactions") }
    /// %d transactions
    internal static func transactionsCount(_ p1: Int) -> String {
      return Strings.tr("Localizable", "BeneficiaryDetails.transactionsCount", p1, fallback: "%d transactions")
    }
    /// Transfer
    internal static var transfer: String { Strings.tr("Localizable", "BeneficiaryDetails.transfer", fallback: "Transfer") }
    /// Transfer sent
    internal static var transferSent: String { Strings.tr("Localizable", "BeneficiaryDetails.transferSent", fallback: "Transfer sent") }
    /// Beneficiary unavailable
    internal static var unavailableTitle: String { Strings.tr("Localizable", "BeneficiaryDetails.unavailableTitle", fallback: "Beneficiary unavailable") }
    /// Verified beneficiary
    internal static var verified: String { Strings.tr("Localizable", "BeneficiaryDetails.verified", fallback: "Verified beneficiary") }
  }
  internal enum BeneficiaryList {
    /// Clear search
    internal static var clearSearch: String { Strings.tr("Localizable", "BeneficiaryList.clearSearch", fallback: "Clear search") }
    /// Saved beneficiaries will appear here.
    internal static var emptyDescription: String { Strings.tr("Localizable", "BeneficiaryList.emptyDescription", fallback: "Saved beneficiaries will appear here.") }
    /// No beneficiaries yet
    internal static var emptyTitle: String { Strings.tr("Localizable", "BeneficiaryList.emptyTitle", fallback: "No beneficiaries yet") }
    /// We couldn't load your beneficiaries right now.
    internal static var loadFailed: String { Strings.tr("Localizable", "BeneficiaryList.loadFailed", fallback: "We couldn't load your beneficiaries right now.") }
    /// No results
    internal static var noSearchResults: String { Strings.tr("Localizable", "BeneficiaryList.noSearchResults", fallback: "No results") }
    /// Recent
    internal static var recent: String { Strings.tr("Localizable", "BeneficiaryList.recent", fallback: "Recent") }
    /// Recent beneficiary
    internal static var recentBeneficiary: String { Strings.tr("Localizable", "BeneficiaryList.recentBeneficiary", fallback: "Recent beneficiary") }
    /// Saved beneficiaries
    internal static var savedBeneficiaries: String { Strings.tr("Localizable", "BeneficiaryList.savedBeneficiaries", fallback: "Saved beneficiaries") }
    /// Saved contact
    internal static var savedContact: String { Strings.tr("Localizable", "BeneficiaryList.savedContact", fallback: "Saved contact") }
    /// Search beneficiaries
    internal static var searchPlaceholder: String { Strings.tr("Localizable", "BeneficiaryList.searchPlaceholder", fallback: "Search beneficiaries") }
    /// Beneficiaries
    internal static var title: String { Strings.tr("Localizable", "BeneficiaryList.title", fallback: "Beneficiaries") }
    /// Try another name or PIX key.
    internal static var tryAnotherSearch: String { Strings.tr("Localizable", "BeneficiaryList.tryAnotherSearch", fallback: "Try another name or PIX key.") }
    /// Beneficiaries unavailable
    internal static var unavailableTitle: String { Strings.tr("Localizable", "BeneficiaryList.unavailableTitle", fallback: "Beneficiaries unavailable") }
  }
  internal enum Common {
    /// Back
    internal static var back: String { Strings.tr("Localizable", "Common.back", fallback: "Back") }
    /// Cancel
    internal static var cancel: String { Strings.tr("Localizable", "Common.cancel", fallback: "Cancel") }
    /// Close
    internal static var close: String { Strings.tr("Localizable", "Common.close", fallback: "Close") }
    /// Continue
    internal static var continueButton: String { Strings.tr("Localizable", "Common.continueButton", fallback: "Continue") }
    /// Failed to submit
    internal static var errorSubmit: String { Strings.tr("Localizable", "Common.errorSubmit", fallback: "Failed to submit") }
    /// Help
    internal static var help: String { Strings.tr("Localizable", "Common.help", fallback: "Help") }
    /// OK
    internal static var ok: String { Strings.tr("Localizable", "Common.ok", fallback: "OK") }
    /// See all
    internal static var seeAll: String { Strings.tr("Localizable", "Common.seeAll", fallback: "See all") }
    /// Try again
    internal static var tryAgain: String { Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again") }
  }
  internal enum HomeApp {
    /// Account terms - Privacy Policy
    internal static var accountTerms: String { Strings.tr("Localizable", "HomeApp.accountTerms", fallback: "Account terms - Privacy Policy") }
    /// Jorge Henrique
    internal static var cardOwnerOne: String { Strings.tr("Localizable", "HomeApp.cardOwnerOne", fallback: "Jorge Henrique") }
    /// Amado Batista
    internal static var cardOwnerTwo: String { Strings.tr("Localizable", "HomeApp.cardOwnerTwo", fallback: "Amado Batista") }
    /// We could not load your cards right now.
    internal static var cardsLoadFailed: String { Strings.tr("Localizable", "HomeApp.cardsLoadFailed", fallback: "We could not load your cards right now.") }
    /// The simulated payments service returned an empty response.
    internal static var emptyDescription: String { Strings.tr("Localizable", "HomeApp.emptyDescription", fallback: "The simulated payments service returned an empty response.") }
    /// We couldn't load your information. Please check your connection and try again.
    internal static var genericErrorDescription: String { Strings.tr("Localizable", "HomeApp.genericErrorDescription", fallback: "We couldn't load your information. Please check your connection and try again.") }
    /// Something went wrong
    internal static var genericErrorTitle: String { Strings.tr("Localizable", "HomeApp.genericErrorTitle", fallback: "Something went wrong") }
    /// Home unavailable
    internal static var homeUnavailableTitle: String { Strings.tr("Localizable", "HomeApp.homeUnavailableTitle", fallback: "Home unavailable") }
    /// Learn More
    internal static var learnMore: String { Strings.tr("Localizable", "HomeApp.learnMore", fallback: "Learn More") }
    /// Logout
    internal static var logout: String { Strings.tr("Localizable", "HomeApp.logout", fallback: "Logout") }
    /// MASTERCARD
    internal static var mastercardBrand: String { Strings.tr("Localizable", "HomeApp.mastercardBrand", fallback: "MASTERCARD") }
    /// Top category: Restaurants 🍔
    internal static var monthlySpendingCaption: String { Strings.tr("Localizable", "HomeApp.monthlySpendingCaption", fallback: "Top category: Restaurants 🍔") }
    /// Monthly Spending
    internal static var monthlySpendingHeadline: String { Strings.tr("Localizable", "HomeApp.monthlySpendingHeadline", fallback: "Monthly Spending") }
    /// You spent $2,310 in August
    internal static var monthlySpendingTitle: String { Strings.tr("Localizable", "HomeApp.monthlySpendingTitle", fallback: "You spent $2,310 in August") }
    /// No dashboard data yet
    internal static var noDashboardDataTitle: String { Strings.tr("Localizable", "HomeApp.noDashboardDataTitle", fallback: "No dashboard data yet") }
    /// @2025 Powered by Blake
    internal static var poweredBy: String { Strings.tr("Localizable", "HomeApp.poweredBy", fallback: "@2025 Powered by Blake") }
    /// See Insights
    internal static var seeInsights: String { Strings.tr("Localizable", "HomeApp.seeInsights", fallback: "See Insights") }
    /// Try later
    internal static var tryLater: String { Strings.tr("Localizable", "HomeApp.tryLater", fallback: "Try later") }
    /// Version 0.00.1
    internal static var version: String { Strings.tr("Localizable", "HomeApp.version", fallback: "Version 0.00.1") }
    /// VISA
    internal static var visaBrand: String { Strings.tr("Localizable", "HomeApp.visaBrand", fallback: "VISA") }
    /// Blake!
    internal static var welcomeName: String { Strings.tr("Localizable", "HomeApp.welcomeName", fallback: "Blake!") }
    /// Welcome, 
    internal static var welcomePrefix: String { Strings.tr("Localizable", "HomeApp.welcomePrefix", fallback: "Welcome, ") }
  }
  internal enum RequestMoney {
    /// Enter an amount
    internal static var amountPlaceholder: String { Strings.tr("Localizable", "RequestMoney.amountPlaceholder", fallback: "Enter an amount") }
    /// How much do you want to request?
    internal static var amountTitle: String { Strings.tr("Localizable", "RequestMoney.amountTitle", fallback: "How much do you want to request?") }
    /// Contact or key
    internal static var contactMode: String { Strings.tr("Localizable", "RequestMoney.contactMode", fallback: "Contact or key") }
    /// Request money from friends, family, or anyone using a contact or Pix key.
    internal static var description: String { Strings.tr("Localizable", "RequestMoney.description", fallback: "Request money from friends, family, or anyone using a contact or Pix key.") }
    /// Edit
    internal static var edit: String { Strings.tr("Localizable", "RequestMoney.edit", fallback: "Edit") }
    /// We could not send the request
    internal static var errorTitle: String { Strings.tr("Localizable", "RequestMoney.errorTitle", fallback: "We could not send the request") }
    /// The request will be sent via Pix. Your contact can pay quickly and securely.
    internal static var previewInformation: String { Strings.tr("Localizable", "RequestMoney.previewInformation", fallback: "The request will be sent via Pix. Your contact can pay quickly and securely.") }
    /// Request preview
    internal static var previewTitle: String { Strings.tr("Localizable", "RequestMoney.previewTitle", fallback: "Request preview") }
    /// Ex: Split dinner, gift, rent...
    internal static var reasonPlaceholder: String { Strings.tr("Localizable", "RequestMoney.reasonPlaceholder", fallback: "Ex: Split dinner, gift, rent...") }
    /// Reason (optional)
    internal static var reasonTitle: String { Strings.tr("Localizable", "RequestMoney.reasonTitle", fallback: "Reason (optional)") }
    /// Recent contacts
    internal static var recentContacts: String { Strings.tr("Localizable", "RequestMoney.recentContacts", fallback: "Recent contacts") }
    /// Name, phone, email, or Pix key
    internal static var recipientPlaceholder: String { Strings.tr("Localizable", "RequestMoney.recipientPlaceholder", fallback: "Name, phone, email, or Pix key") }
    /// Who do you want to request from?
    internal static var recipientTitle: String { Strings.tr("Localizable", "RequestMoney.recipientTitle", fallback: "Who do you want to request from?") }
    /// Choose who should receive this request
    internal static var selectBeneficiaryDescription: String { Strings.tr("Localizable", "RequestMoney.selectBeneficiaryDescription", fallback: "Choose who should receive this request") }
    /// Select a beneficiary
    internal static var selectBeneficiaryTitle: String { Strings.tr("Localizable", "RequestMoney.selectBeneficiaryTitle", fallback: "Select a beneficiary") }
    /// Send request
    internal static var sendRequest: String { Strings.tr("Localizable", "RequestMoney.sendRequest", fallback: "Send request") }
    /// How much do you want to charge?
    internal static var shareAmountTitle: String { Strings.tr("Localizable", "RequestMoney.shareAmountTitle", fallback: "How much do you want to charge?") }
    /// A payment request link will be created for you to share in any app.
    internal static var shareDescription: String { Strings.tr("Localizable", "RequestMoney.shareDescription", fallback: "A payment request link will be created for you to share in any app.") }
    /// Share request
    internal static var shareMode: String { Strings.tr("Localizable", "RequestMoney.shareMode", fallback: "Share request") }
    /// Share request
    internal static var shareRequest: String { Strings.tr("Localizable", "RequestMoney.shareRequest", fallback: "Share request") }
    /// Request money
    internal static var title: String { Strings.tr("Localizable", "RequestMoney.title", fallback: "Request money") }
    /// To
    internal static var to: String { Strings.tr("Localizable", "RequestMoney.to", fallback: "To") }
    /// We could not load your contacts
    internal static var unavailableTitle: String { Strings.tr("Localizable", "RequestMoney.unavailableTitle", fallback: "We could not load your contacts") }
    /// You request
    internal static var youRequest: String { Strings.tr("Localizable", "RequestMoney.youRequest", fallback: "You request") }
  }
  internal enum SendMoney {
    /// Continue
    internal static var continueButton: String { Strings.tr("Localizable", "SendMoney.continueButton", fallback: "Continue") }
    /// Transfer
    internal static var title: String { Strings.tr("Localizable", "SendMoney.title", fallback: "Transfer") }
  }
  internal enum TransferBeneficiary {
    /// Change
    internal static var change: String { Strings.tr("Localizable", "TransferBeneficiary.change", fallback: "Change") }
    /// Select
    internal static var select: String { Strings.tr("Localizable", "TransferBeneficiary.select", fallback: "Select") }
    /// Choose who should receive this transfer
    internal static var selectDescription: String { Strings.tr("Localizable", "TransferBeneficiary.selectDescription", fallback: "Choose who should receive this transfer") }
    /// Select a beneficiary
    internal static var selectTitle: String { Strings.tr("Localizable", "TransferBeneficiary.selectTitle", fallback: "Select a beneficiary") }
  }
  internal enum TransferPin {
    /// Confirm Transfer
    internal static var confirmTransfer: String { Strings.tr("Localizable", "TransferPin.confirmTransfer", fallback: "Confirm Transfer") }
    /// Enter your 4-digit PIN to send
    /// %1$@ to %2$@.
    internal static func subtitle(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "TransferPin.subtitle", String(describing: p1), String(describing: p2), fallback: "Enter your 4-digit PIN to send\n%1$@ to %2$@.")
    }
    /// Enter your PIN
    internal static var title: String { Strings.tr("Localizable", "TransferPin.title", fallback: "Enter your PIN") }
    /// The PIN could not be validated. Please review it and start the transfer again.
    internal static var validationErrorDescription: String { Strings.tr("Localizable", "TransferPin.validationErrorDescription", fallback: "The PIN could not be validated. Please review it and start the transfer again.") }
    /// We couldn't confirm your identity
    internal static var validationErrorTitle: String { Strings.tr("Localizable", "TransferPin.validationErrorTitle", fallback: "We couldn't confirm your identity") }
  }
  internal enum TransferProcessing {
    /// No money was deducted. You can try again now or return to the transfer later.
    internal static var errorDescription: String { Strings.tr("Localizable", "TransferProcessing.errorDescription", fallback: "No money was deducted. You can try again now or return to the transfer later.") }
    /// We couldn't complete your transfer
    internal static var errorTitle: String { Strings.tr("Localizable", "TransferProcessing.errorTitle", fallback: "We couldn't complete your transfer") }
    /// Please don't close the app
    /// or go back.
    internal static var subtitle: String { Strings.tr("Localizable", "TransferProcessing.subtitle", fallback: "Please don't close the app\nor go back.") }
    /// Processing transfer...
    internal static var title: String { Strings.tr("Localizable", "TransferProcessing.title", fallback: "Processing transfer...") }
  }
  internal enum TransferSuccess {
    /// Amount
    internal static var amount: String { Strings.tr("Localizable", "TransferSuccess.amount", fallback: "Amount") }
    /// Make another transfer
    internal static var anotherTransfer: String { Strings.tr("Localizable", "TransferSuccess.anotherTransfer", fallback: "Make another transfer") }
    /// Completed
    internal static var completed: String { Strings.tr("Localizable", "TransferSuccess.completed", fallback: "Completed") }
    /// Date & Time
    internal static var dateAndTime: String { Strings.tr("Localizable", "TransferSuccess.dateAndTime", fallback: "Date & Time") }
    /// Done
    internal static var done: String { Strings.tr("Localizable", "TransferSuccess.done", fallback: "Done") }
    /// From
    internal static var from: String { Strings.tr("Localizable", "TransferSuccess.from", fallback: "From") }
    /// Main Account
    internal static var mainAccount: String { Strings.tr("Localizable", "TransferSuccess.mainAccount", fallback: "Main Account") }
    /// Reference ID
    internal static var referenceId: String { Strings.tr("Localizable", "TransferSuccess.referenceId", fallback: "Reference ID") }
    /// Your transaction is protected and encrypted.
    internal static var secureSubtitle: String { Strings.tr("Localizable", "TransferSuccess.secureSubtitle", fallback: "Your transaction is protected and encrypted.") }
    /// Secure transfer
    internal static var secureTransfer: String { Strings.tr("Localizable", "TransferSuccess.secureTransfer", fallback: "Secure transfer") }
    /// Your money has been sent successfully.
    internal static var subtitle: String { Strings.tr("Localizable", "TransferSuccess.subtitle", fallback: "Your money has been sent successfully.") }
    /// Transfer successful!
    internal static var title: String { Strings.tr("Localizable", "TransferSuccess.title", fallback: "Transfer successful!") }
    /// To
    internal static var to: String { Strings.tr("Localizable", "TransferSuccess.to", fallback: "To") }
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
