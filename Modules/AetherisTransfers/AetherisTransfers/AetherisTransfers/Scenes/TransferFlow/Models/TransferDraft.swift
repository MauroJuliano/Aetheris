import Foundation

struct TransferDraft: Hashable {
    let amount: Decimal
    let formattedAmount: String
    let currency: String
    let beneficiaryName: String
    let beneficiaryIdentifier: String
    let accountName: String
    let accountLastDigits: String
}
