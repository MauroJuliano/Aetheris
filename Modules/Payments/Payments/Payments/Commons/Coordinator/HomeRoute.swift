import Foundation

enum HomeRoute: Hashable {
    case card
    case transactionHistory
    case sendMoney
    case sendMoneyBeneficiaryList
    case sendMoneyPin(TransferReceiptModel)
    case sendMoneyProcessing(TransferReceiptModel)
    case sendMoneySuccess(TransferReceiptModel)
    case beneficiaryList
    case addBeneficiary
    case notifications
    case allServices
    case insurance
    case viewReport
}
