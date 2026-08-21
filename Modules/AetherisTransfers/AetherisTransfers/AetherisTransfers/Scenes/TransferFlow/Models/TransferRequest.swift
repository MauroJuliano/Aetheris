import Foundation

struct TransferRequest: Encodable {
    let amount: Decimal
    let currency: String
    let beneficiaryIdentifier: String
    let authorizationToken: String
}
