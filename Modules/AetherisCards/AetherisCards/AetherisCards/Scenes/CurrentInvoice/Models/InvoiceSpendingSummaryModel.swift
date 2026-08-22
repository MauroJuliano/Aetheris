import Foundation

struct InvoiceSpendingSummaryModel: Codable, Equatable {
    let totalSpent: Decimal
    let installmentPurchases: Decimal
    let oneTimePurchases: Decimal

    var installmentProgress: Double {
        guard totalSpent > 0 else { return 0 }
        return NSDecimalNumber(decimal: installmentPurchases / totalSpent).doubleValue
    }

    var oneTimeProgress: Double {
        guard totalSpent > 0 else { return 0 }
        return NSDecimalNumber(decimal: oneTimePurchases / totalSpent).doubleValue
    }
}
