import Foundation

struct CurrentInvoiceDetailsModel: Codable, Equatable {
    let purchasesSubtotal: Decimal
    let otherCharges: Decimal
    let discountsAndCredits: Decimal
    let total: Decimal
}
