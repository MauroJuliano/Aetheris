// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum AllServices {
    /// Cards
    internal static let cardCenter = Strings.tr("Localizable", "AllServices.cardCenter", fallback: "Cards")
    /// Insurance
    internal static let insurance = Strings.tr("Localizable", "AllServices.insurance", fallback: "Insurance")
    /// Beneficiaries
    internal static let manageBeneficiaries = Strings.tr("Localizable", "AllServices.manageBeneficiaries", fallback: "Beneficiaries")
    /// Notifications
    internal static let notifications = Strings.tr("Localizable", "AllServices.notifications", fallback: "Notifications")
    /// Reports
    internal static let reports = Strings.tr("Localizable", "AllServices.reports", fallback: "Reports")
    /// Quick access to the main services available in the app.
    internal static let subtitle = Strings.tr("Localizable", "AllServices.subtitle", fallback: "Quick access to the main services available in the app.")
    /// All services
    internal static let title = Strings.tr("Localizable", "AllServices.title", fallback: "All services")
    /// Transfer money
    internal static let transferMoney = Strings.tr("Localizable", "AllServices.transferMoney", fallback: "Transfer money")
  }
  internal enum BeneficiaryAdd {
    /// Enter an email or PIX key to continue.
    internal static let invalidSearch = Strings.tr("Localizable", "BeneficiaryAdd.invalidSearch", fallback: "Enter an email or PIX key to continue.")
    /// Search an existing recipient to use in this transfer.
    internal static let subtitle = Strings.tr("Localizable", "BeneficiaryAdd.subtitle", fallback: "Search an existing recipient to use in this transfer.")
    /// Find beneficiary
    internal static let title = Strings.tr("Localizable", "BeneficiaryAdd.title", fallback: "Find beneficiary")
    /// Find beneficiary
    internal static let searchButton = Strings.tr("Localizable", "BeneficiaryAdd.searchButton", fallback: "Find beneficiary")
    /// Enter an email or PIX key
    internal static let searchPlaceholder = Strings.tr("Localizable", "BeneficiaryAdd.searchPlaceholder", fallback: "Enter email or PIX key")
    /// Email or PIX key
    internal static let searchLabel = Strings.tr("Localizable", "BeneficiaryAdd.searchLabel", fallback: "Email or PIX key")
    /// We could not find this beneficiary right now.
    internal static let searchFailed = Strings.tr("Localizable", "BeneficiaryAdd.searchFailed", fallback: "We could not find this beneficiary right now.")
    /// Searching...
    internal static let searching = Strings.tr("Localizable", "BeneficiaryAdd.searching", fallback: "Searching...")
    /// Enter the email or PIX key for the person you want to find.
    internal static let description = Strings.tr("Localizable", "BeneficiaryAdd.description", fallback: "Enter the email or PIX key for the person you want to find.")
  }
  internal enum CardHome {
    /// Cards
    internal static let title = Strings.tr("Localizable", "CardHome.title", fallback: "Cards")
  }
  internal enum CardInsurance {
    /// Extended benefits for cardholders traveling abroad (e.g., lost luggage or emergency cash).
    internal static let bulletFour = Strings.tr("Localizable", "CardInsurance.bulletFour", fallback: "Extended benefits for cardholders traveling abroad (e.g., lost luggage or emergency cash).")
    /// Covers unauthorized transactions made after card theft or cloning.
    internal static let bulletOne = Strings.tr("Localizable", "CardInsurance.bulletOne", fallback: "Covers unauthorized transactions made after card theft or cloning.")
    /// Insures eligible purchases against damage or theft for a limited period
    internal static let bulletThree = Strings.tr("Localizable", "CardInsurance.bulletThree", fallback: "Insures eligible purchases against damage or theft for a limited period")
    /// Quick replacement of lost or stolen cards.
    internal static let bulletTwo = Strings.tr("Localizable", "CardInsurance.bulletTwo", fallback: "Quick replacement of lost or stolen cards.")
    /// Continue
    internal static let `continue` = Strings.tr("Localizable", "CardInsurance.continue", fallback: "Continue")
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "CardInsurance.continueButton", fallback: "Continue")
  }
  internal enum Common {
    /// Back
    internal static let back = Strings.tr("Localizable", "Common.back", fallback: "Back")
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "Common.continueButton", fallback: "Continue")
    /// Failed to submit
    internal static let errorSubmit = Strings.tr("Localizable", "Common.errorSubmit", fallback: "Failed to submit")
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again")
  }
  internal enum FinancialSummary {
    /// Apple.Com/Bill
    internal static let appleBill = Strings.tr("Localizable", "FinancialSummary.appleBill", fallback: "Apple.Com/Bill")
    /// %d days ago
    internal static func daysAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.daysAgo", p1, fallback: "%d days ago")
    }
    /// Ifd* Bar do zé
    internal static let ifoodBar = Strings.tr("Localizable", "FinancialSummary.ifoodBar", fallback: "Ifd* Bar do zé")
    /// %d month ago
    internal static func monthAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.monthAgo", p1, fallback: "%d month ago")
    }
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "FinancialSummary.netflix", fallback: "Netflix")
    /// Payment received
    internal static let paymentReceived = Strings.tr("Localizable", "FinancialSummary.paymentReceived", fallback: "Payment received")
    /// Funds received from Ed Sheeran
    internal static let paymentReceivedDescription = Strings.tr("Localizable", "FinancialSummary.paymentReceivedDescription", fallback: "Funds received from Ed Sheeran")
    /// Restaurant
    internal static let restaurant = Strings.tr("Localizable", "FinancialSummary.restaurant", fallback: "Restaurant")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "FinancialSummary.subscription", fallback: "Subscription")
    /// Transfer sent
    internal static let transferSent = Strings.tr("Localizable", "FinancialSummary.transferSent", fallback: "Transfer sent")
    /// Funds successfully transferred to Adele
    internal static let transferSentAdeleDescription = Strings.tr("Localizable", "FinancialSummary.transferSentAdeleDescription", fallback: "Funds successfully transferred to Adele")
    /// Funds successfully transferred to Melissa
    internal static let transferSentDescription = Strings.tr("Localizable", "FinancialSummary.transferSentDescription", fallback: "Funds successfully transferred to Melissa")
  }
  internal enum HomeApp {
    /// Account terms - Privacy Policy
    internal static let accountTerms = Strings.tr("Localizable", "HomeApp.accountTerms", fallback: "Account terms - Privacy Policy")
    /// Apply Now
    internal static let applyNow = Strings.tr("Localizable", "HomeApp.applyNow", fallback: "Apply Now")
    /// Apply now for a Platinum Secured Card
    internal static let buildYourCreditCaption = Strings.tr("Localizable", "HomeApp.buildYourCreditCaption", fallback: "Apply now for a Platinum Secured Card")
    /// Build Your Credit
    internal static let buildYourCreditTitle = Strings.tr("Localizable", "HomeApp.buildYourCreditTitle", fallback: "Build Your Credit")
    /// Change the email used for notifications and contact.
    internal static let editEmailDescription = Strings.tr("Localizable", "HomeApp.editEmailDescription", fallback: "Change the email used for notifications and contact.")
    /// Enter email
    internal static let editEmailPlaceholder = Strings.tr("Localizable", "HomeApp.editEmailPlaceholder", fallback: "Enter email")
    /// Edit email
    internal static let editEmailTitle = Strings.tr("Localizable", "HomeApp.editEmailTitle", fallback: "Edit email")
    /// Update the public profile name shown in the app.
    internal static let editNameDescription = Strings.tr("Localizable", "HomeApp.editNameDescription", fallback: "Update the public profile name shown in the app.")
    /// Enter full name
    internal static let editNamePlaceholder = Strings.tr("Localizable", "HomeApp.editNamePlaceholder", fallback: "Enter full name")
    /// Edit name
    internal static let editNameTitle = Strings.tr("Localizable", "HomeApp.editNameTitle", fallback: "Edit name")
    /// Update the number associated with the account.
    internal static let editPhoneDescription = Strings.tr("Localizable", "HomeApp.editPhoneDescription", fallback: "Update the number associated with the account.")
    /// Enter phone number
    internal static let editPhonePlaceholder = Strings.tr("Localizable", "HomeApp.editPhonePlaceholder", fallback: "Enter phone number")
    /// Edit phone
    internal static let editPhoneTitle = Strings.tr("Localizable", "HomeApp.editPhoneTitle", fallback: "Edit phone")
    /// The simulated payments service returned an empty response.
    internal static let emptyDescription = Strings.tr("Localizable", "HomeApp.emptyDescription", fallback: "The simulated payments service returned an empty response.")
    /// We couldn't load your information. Please check your connection and try again.
    internal static let genericErrorDescription = Strings.tr("Localizable", "HomeApp.genericErrorDescription", fallback: "We couldn't load your information. Please check your connection and try again.")
    /// Something went wrong
    internal static let genericErrorTitle = Strings.tr("Localizable", "HomeApp.genericErrorTitle", fallback: "Something went wrong")
    /// Home unavailable
    internal static let homeUnavailableTitle = Strings.tr("Localizable", "HomeApp.homeUnavailableTitle", fallback: "Home unavailable")
    /// Learn More
    internal static let learnMore = Strings.tr("Localizable", "HomeApp.learnMore", fallback: "Learn More")
    /// Logout
    internal static let logout = Strings.tr("Localizable", "HomeApp.logout", fallback: "Logout")
    /// Jorge Henrique
    internal static let mockCardOwnerOne = Strings.tr("Localizable", "HomeApp.mockCardOwnerOne", fallback: "Jorge Henrique")
    /// Amado batista
    internal static let mockCardOwnerTwo = Strings.tr("Localizable", "HomeApp.mockCardOwnerTwo", fallback: "Amado batista")
    /// MASTERCARD
    internal static let mockMastercard = Strings.tr("Localizable", "HomeApp.mockMastercard", fallback: "MASTERCARD")
    /// VISA
    internal static let mockVisa = Strings.tr("Localizable", "HomeApp.mockVisa", fallback: "VISA")
    /// Top category: Restaurants 🍔
    internal static let monthlySpendingCaption = Strings.tr("Localizable", "HomeApp.monthlySpendingCaption", fallback: "Top category: Restaurants 🍔")
    /// Monthly Spending
    internal static let monthlySpendingHeadline = Strings.tr("Localizable", "HomeApp.monthlySpendingHeadline", fallback: "Monthly Spending")
    /// You spent $2,310 in August
    internal static let monthlySpendingTitle = Strings.tr("Localizable", "HomeApp.monthlySpendingTitle", fallback: "You spent $2,310 in August")
    /// No Credit Card Yet?
    internal static let noCreditCardHeadline = Strings.tr("Localizable", "HomeApp.noCreditCardHeadline", fallback: "No Credit Card Yet?")
    /// No dashboard data yet
    internal static let noDashboardDataTitle = Strings.tr("Localizable", "HomeApp.noDashboardDataTitle", fallback: "No dashboard data yet")
    /// @2025 Powered by Blake
    internal static let poweredBy = Strings.tr("Localizable", "HomeApp.poweredBy", fallback: "@2025 Powered by Blake")
    /// Redeem
    internal static let redeem = Strings.tr("Localizable", "HomeApp.redeem", fallback: "Redeem")
    /// Worth $125 in travel
    internal static let rewardsCaption = Strings.tr("Localizable", "HomeApp.rewardsCaption", fallback: "Worth $125 in travel")
    /// Rewards Available
    internal static let rewardsHeadline = Strings.tr("Localizable", "HomeApp.rewardsHeadline", fallback: "Rewards Available")
    /// 12,500 points
    internal static let rewardsTitle = Strings.tr("Localizable", "HomeApp.rewardsTitle", fallback: "12,500 points")
    /// See Insights
    internal static let seeInsights = Strings.tr("Localizable", "HomeApp.seeInsights", fallback: "See Insights")
    /// Protect your trips starting at $12/mo
    internal static let specialOfferCaption = Strings.tr("Localizable", "HomeApp.specialOfferCaption", fallback: "Protect your trips starting at $12/mo")
    /// Special Offer
    internal static let specialOfferHeadline = Strings.tr("Localizable", "HomeApp.specialOfferHeadline", fallback: "Special Offer")
    /// Travel Insurance
    internal static let specialOfferTitle = Strings.tr("Localizable", "HomeApp.specialOfferTitle", fallback: "Travel Insurance")
    /// Try later
    internal static let tryLater = Strings.tr("Localizable", "HomeApp.tryLater", fallback: "Try later")
    /// Version 0.00.1
    internal static let version = Strings.tr("Localizable", "HomeApp.version", fallback: "Version 0.00.1")
    /// Blake!
    internal static let welcomeName = Strings.tr("Localizable", "HomeApp.welcomeName", fallback: "Blake!")
    /// Welcome, 
    internal static let welcomePrefix = Strings.tr("Localizable", "HomeApp.welcomePrefix", fallback: "Welcome, ")
  }
  internal enum HomeCard {
    /// Cards unavailable
    internal static let cardsUnavailableTitle = Strings.tr("Localizable", "HomeCard.cardsUnavailableTitle", fallback: "Cards unavailable")
    /// This area will reflect the dashboard when the simulated service returns data.
    internal static let emptyDescription = Strings.tr("Localizable", "HomeCard.emptyDescription", fallback: "This area will reflect the dashboard when the simulated service returns data.")
    /// No cards or activity yet
    internal static let emptyTitle = Strings.tr("Localizable", "HomeCard.emptyTitle", fallback: "No cards or activity yet")
  }
  internal enum InsuranceOnboarding {
    /// Seamless integration with your finance dashboard
    internal static let benefitFour = Strings.tr("Localizable", "InsuranceOnboarding.benefitFour", fallback: "Seamless integration with your finance dashboard")
    /// Fast and simple digital claims
    internal static let benefitOne = Strings.tr("Localizable", "InsuranceOnboarding.benefitOne", fallback: "Fast and simple digital claims")
    /// Benefits:
    internal static let benefits = Strings.tr("Localizable", "InsuranceOnboarding.benefits", fallback: "Benefits:")
    /// Flexible coverage options for any budget
    internal static let benefitThree = Strings.tr("Localizable", "InsuranceOnboarding.benefitThree", fallback: "Flexible coverage options for any budget")
    /// 24/7 customer support
    internal static let benefitTwo = Strings.tr("Localizable", "InsuranceOnboarding.benefitTwo", fallback: "24/7 customer support")
    /// Continue
    internal static let `continue` = Strings.tr("Localizable", "InsuranceOnboarding.continue", fallback: "Continue")
    /// More options
    internal static let moreOptions = Strings.tr("Localizable", "InsuranceOnboarding.moreOptions", fallback: "More options")
    /// Secure your future with our comprehensive financial insurance plan.
    internal static let subtitle = Strings.tr("Localizable", "InsuranceOnboarding.subtitle", fallback: "Secure your future with our comprehensive financial insurance plan.")
  }
  internal enum Notifications {
    /// Last Month
    internal static let sectionLastMonth = Strings.tr("Localizable", "Notifications.sectionLastMonth", fallback: "Last Month")
    /// Last Week
    internal static let sectionLastWeek = Strings.tr("Localizable", "Notifications.sectionLastWeek", fallback: "Last Week")
    /// Others
    internal static let sectionOthers = Strings.tr("Localizable", "Notifications.sectionOthers", fallback: "Others")
    /// Today
    internal static let sectionToday = Strings.tr("Localizable", "Notifications.sectionToday", fallback: "Today")
    /// Yesterday
    internal static let sectionYesterday = Strings.tr("Localizable", "Notifications.sectionYesterday", fallback: "Yesterday")
    /// System maintenance completed
    internal static let titleMaintenanceCompleted = Strings.tr("Localizable", "Notifications.titleMaintenanceCompleted", fallback: "System maintenance completed")
    /// Payment received from Ed
    internal static let titlePaymentReceived = Strings.tr("Localizable", "Notifications.titlePaymentReceived", fallback: "Payment received from Ed")
    /// Refund processed successfully
    internal static let titleRefundProcessed = Strings.tr("Localizable", "Notifications.titleRefundProcessed", fallback: "Refund processed successfully")
    /// Your subscription has expired
    internal static let titleSubscriptionExpired = Strings.tr("Localizable", "Notifications.titleSubscriptionExpired", fallback: "Your subscription has expired")
    /// Subscription renewed for Man's best Friend
    internal static let titleSubscriptionRenewed = Strings.tr("Localizable", "Notifications.titleSubscriptionRenewed", fallback: "Subscription renewed for Man's best Friend")
    /// Funds successfully transferred to Melissa
    internal static let titleTransferSent = Strings.tr("Localizable", "Notifications.titleTransferSent", fallback: "Funds successfully transferred to Melissa")
  }
  internal enum NotificationsCentre {
    /// The simulated service has no notifications to show.
    internal static let emptyDescription = Strings.tr("Localizable", "NotificationsCentre.emptyDescription", fallback: "The simulated service has no notifications to show.")
    /// No notifications yet
    internal static let emptyTitle = Strings.tr("Localizable", "NotificationsCentre.emptyTitle", fallback: "No notifications yet")
    /// Notifications
    internal static let title = Strings.tr("Localizable", "NotificationsCentre.title", fallback: "Notifications")
    /// Notifications unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "NotificationsCentre.unavailableTitle", fallback: "Notifications unavailable")
  }
  internal enum Profile {
    /// Confirm logout
    internal static let confirmLogout = Strings.tr("Localizable", "Profile.confirmLogout", fallback: "Confirm logout")
    /// Done
    internal static let done = Strings.tr("Localizable", "Profile.done", fallback: "Done")
    /// Edit email
    internal static let editEmailTitle = Strings.tr("Localizable", "Profile.editEmailTitle", fallback: "Edit email")
    /// Edit name
    internal static let editNameTitle = Strings.tr("Localizable", "Profile.editNameTitle", fallback: "Edit name")
    /// Edit phone
    internal static let editPhoneTitle = Strings.tr("Localizable", "Profile.editPhoneTitle", fallback: "Edit phone")
    /// contact@melissamccarthy.com
    internal static let email = Strings.tr("Localizable", "Profile.email", fallback: "contact@melissamccarthy.com")
    /// Tell us what can be improved in the app experience.
    internal static let feedbackDescription = Strings.tr("Localizable", "Profile.feedbackDescription", fallback: "Tell us what can be improved in the app experience.")
    /// Feedback
    internal static let feedbackTitle = Strings.tr("Localizable", "Profile.feedbackTitle", fallback: "Feedback")
    /// This is a mocked legal page used to keep the profile flow realistic while remaining fully local to the app.
    internal static let legalDescription = Strings.tr("Localizable", "Profile.legalDescription", fallback: "This is a mocked legal page used to keep the profile flow realistic while remaining fully local to the app.")
    /// Logout
    internal static let logout = Strings.tr("Localizable", "Profile.logout", fallback: "Logout")
    /// This is a mocked logout action used for the profile flow.
    internal static let logoutDescription = Strings.tr("Localizable", "Profile.logoutDescription", fallback: "This is a mocked logout action used for the profile flow.")
    /// (33) 9908-3213
    internal static let phone = Strings.tr("Localizable", "Profile.phone", fallback: "(33) 9908-3213")
    /// @2025 Powered by Blake
    internal static let poweredBy = Strings.tr("Localizable", "Profile.poweredBy", fallback: "@2025 Powered by Blake")
    /// Privacy Policy
    internal static let privacyPolicy = Strings.tr("Localizable", "Profile.privacyPolicy", fallback: "Privacy Policy")
    /// Save
    internal static let save = Strings.tr("Localizable", "Profile.save", fallback: "Save")
    /// Send feedback
    internal static let sendFeedback = Strings.tr("Localizable", "Profile.sendFeedback", fallback: "Send feedback")
    /// Account terms - Privacy Policy
    internal static let terms = Strings.tr("Localizable", "Profile.terms", fallback: "Account terms - Privacy Policy")
    /// Melissa Mccarthy
    internal static let userName = Strings.tr("Localizable", "Profile.userName", fallback: "Melissa Mccarthy")
    /// Version 0.00.1
    internal static let version = Strings.tr("Localizable", "Profile.version", fallback: "Version 0.00.1")
  }
  internal enum QuickActions {
    /// All services
    internal static let moreSubtitle = Strings.tr("Localizable", "QuickActions.moreSubtitle", fallback: "All services")
    /// More
    internal static let moreTitle = Strings.tr("Localizable", "QuickActions.moreTitle", fallback: "More")
    /// Pay
    internal static let payTitle = Strings.tr("Localizable", "QuickActions.payTitle", fallback: "Pay")
    /// Receive money
    internal static let requestSubtitle = Strings.tr("Localizable", "QuickActions.requestSubtitle", fallback: "Receive money")
    /// Request
    internal static let requestTitle = Strings.tr("Localizable", "QuickActions.requestTitle", fallback: "Request")
    /// What would you like to do ?
    internal static let sectionTitle = Strings.tr("Localizable", "QuickActions.sectionTitle", fallback: "What would you like to do ?")
    /// Send
    internal static let sendTitle = Strings.tr("Localizable", "QuickActions.sendTitle", fallback: "Send")
    /// Top up
    internal static let topUpTitle = Strings.tr("Localizable", "QuickActions.topUpTitle", fallback: "Top up")
    /// Send money
    internal static let transferSubtitle = Strings.tr("Localizable", "QuickActions.transferSubtitle", fallback: "Send money")
    /// Transfer
    internal static let transferTitle = Strings.tr("Localizable", "QuickActions.transferTitle", fallback: "Transfer")
  }
  internal enum Recipients {
    /// New
    /// recipient
    internal static let newRecipient = Strings.tr("Localizable", "Recipients.newRecipient", fallback: "New\nrecipient")
    /// See all
    internal static let seeAll = Strings.tr("Localizable", "Recipients.seeAll", fallback: "See all")
    /// Recipients
    internal static let title = Strings.tr("Localizable", "Recipients.title", fallback: "Recipients")
  }
  internal enum SendMoney {
    /// Continue
    internal static let continueButton = Strings.tr("Localizable", "SendMoney.continueButton", fallback: "Continue")
    /// Transfer
    internal static let title = Strings.tr("Localizable", "SendMoney.title", fallback: "Transfer")
  }
  internal enum SpendingChart {
    /// Bills
    internal static let bills = Strings.tr("Localizable", "SpendingChart.bills", fallback: "Bills")
    /// 8.3%
    internal static let change = Strings.tr("Localizable", "SpendingChart.change", fallback: "8.3%")
    /// vs last month
    internal static let comparison = Strings.tr("Localizable", "SpendingChart.comparison", fallback: "vs last month")
    /// Food & Drinks
    internal static let foodAndDrinks = Strings.tr("Localizable", "SpendingChart.foodAndDrinks", fallback: "Food & Drinks")
    /// Shopping
    internal static let shopping = Strings.tr("Localizable", "SpendingChart.shopping", fallback: "Shopping")
    /// Spending this month
    internal static let title = Strings.tr("Localizable", "SpendingChart.title", fallback: "Spending this month")
    /// $ 2,428.00
    internal static let total = Strings.tr("Localizable", "SpendingChart.total", fallback: "$ 2,428.00")
    /// Transport
    internal static let transport = Strings.tr("Localizable", "SpendingChart.transport", fallback: "Transport")
    /// View report
    internal static let viewReport = Strings.tr("Localizable", "SpendingChart.viewReport", fallback: "View report")
  }
  internal enum TransactionHistory {
    /// This account does not have transaction history in the simulated dataset.
    internal static let emptyDescription = Strings.tr("Localizable", "TransactionHistory.emptyDescription", fallback: "This account does not have transaction history in the simulated dataset.")
    /// No transactions yet
    internal static let emptyTitle = Strings.tr("Localizable", "TransactionHistory.emptyTitle", fallback: "No transactions yet")
    /// Transaction History
    internal static let title = Strings.tr("Localizable", "TransactionHistory.title", fallback: "Transaction History")
    /// History unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "TransactionHistory.unavailableTitle", fallback: "History unavailable")
  }
  internal enum TransactionsHistory {
    /// Apple
    internal static let apple = Strings.tr("Localizable", "TransactionsHistory.apple", fallback: "Apple")
    /// Deposit
    internal static let deposit = Strings.tr("Localizable", "TransactionsHistory.deposit", fallback: "Deposit")
    /// Melissa
    internal static let melissa = Strings.tr("Localizable", "TransactionsHistory.melissa", fallback: "Melissa")
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "TransactionsHistory.netflix", fallback: "Netflix")
    /// Payment
    internal static let payment = Strings.tr("Localizable", "TransactionsHistory.payment", fallback: "Payment")
    /// Purchase
    internal static let purchase = Strings.tr("Localizable", "TransactionsHistory.purchase", fallback: "Purchase")
    /// Salary
    internal static let salary = Strings.tr("Localizable", "TransactionsHistory.salary", fallback: "Salary")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "TransactionsHistory.subscription", fallback: "Subscription")
    /// Swarovski
    internal static let swarovski = Strings.tr("Localizable", "TransactionsHistory.swarovski", fallback: "Swarovski")
    /// Transactions History
    internal static let title = Strings.tr("Localizable", "TransactionsHistory.title", fallback: "Transactions History")
    /// Transfer received
    internal static let transferReceived = Strings.tr("Localizable", "TransactionsHistory.transferReceived", fallback: "Transfer received")
  }
  internal enum TransferBeneficiary {
    /// Change
    internal static let change = Strings.tr("Localizable", "TransferBeneficiary.change", fallback: "Change")
  }
  internal enum TransferPin {
    /// You have %d attempts left.
    internal static func attempts(_ p1: Int) -> String {
      return Strings.tr("Localizable", "TransferPin.attempts", p1, fallback: "You have %d attempts left.")
    }
    /// Confirm Transfer
    internal static let confirmTransfer = Strings.tr("Localizable", "TransferPin.confirmTransfer", fallback: "Confirm Transfer")
    /// Incorrect PIN. Try again.
    internal static let incorrect = Strings.tr("Localizable", "TransferPin.incorrect", fallback: "Incorrect PIN. Try again.")
    /// Enter your 4-digit PIN to send
    /// $250.00 to Melissa Johnson.
    internal static let subtitle = Strings.tr("Localizable", "TransferPin.subtitle", fallback: "Enter your 4-digit PIN to send\n$250.00 to Melissa Johnson.")
    /// Enter your PIN
    internal static let title = Strings.tr("Localizable", "TransferPin.title", fallback: "Enter your PIN")
    /// Use Face ID
    internal static let useFaceID = Strings.tr("Localizable", "TransferPin.useFaceID", fallback: "Use Face ID")
  }
  internal enum TransferProcessing {
    /// Please don't close the app
    /// or go back.
    internal static let subtitle = Strings.tr("Localizable", "TransferProcessing.subtitle", fallback: "Please don't close the app\nor go back.")
    /// Processing transfer...
    internal static let title = Strings.tr("Localizable", "TransferProcessing.title", fallback: "Processing transfer...")
  }
  internal enum TransferSuccess {
    /// Amount
    internal static let amount = Strings.tr("Localizable", "TransferSuccess.amount", fallback: "Amount")
    /// Make another transfer
    internal static let anotherTransfer = Strings.tr("Localizable", "TransferSuccess.anotherTransfer", fallback: "Make another transfer")
    /// Completed
    internal static let completed = Strings.tr("Localizable", "TransferSuccess.completed", fallback: "Completed")
    /// Date & Time
    internal static let dateAndTime = Strings.tr("Localizable", "TransferSuccess.dateAndTime", fallback: "Date & Time")
    /// Done
    internal static let done = Strings.tr("Localizable", "TransferSuccess.done", fallback: "Done")
    /// From
    internal static let from = Strings.tr("Localizable", "TransferSuccess.from", fallback: "From")
    /// Reference ID
    internal static let referenceId = Strings.tr("Localizable", "TransferSuccess.referenceId", fallback: "Reference ID")
    /// Your transaction is protected and encrypted.
    internal static let secureSubtitle = Strings.tr("Localizable", "TransferSuccess.secureSubtitle", fallback: "Your transaction is protected and encrypted.")
    /// Secure transfer
    internal static let secureTransfer = Strings.tr("Localizable", "TransferSuccess.secureTransfer", fallback: "Secure transfer")
    /// Your money has been sent successfully.
    internal static let subtitle = Strings.tr("Localizable", "TransferSuccess.subtitle", fallback: "Your money has been sent successfully.")
    /// Transfer successful!
    internal static let title = Strings.tr("Localizable", "TransferSuccess.title", fallback: "Transfer successful!")
    /// To
    internal static let to = Strings.tr("Localizable", "TransferSuccess.to", fallback: "To")
  }
  internal enum ViewReport {
    /// View Report
    internal static let loadingTitle = Strings.tr("Localizable", "ViewReport.loadingTitle", fallback: "View Report")
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
