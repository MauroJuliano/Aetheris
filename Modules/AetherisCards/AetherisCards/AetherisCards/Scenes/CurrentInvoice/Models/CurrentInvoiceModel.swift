import SwiftUI

struct CurrentInvoiceModel: Identifiable, Codable, Equatable {
    let id: UUID
    let cardId: UUID
    let amount: Decimal
    let status: InvoiceStatus
    let dueDate: Date
    let bestPurchaseDate: Date
    let totalLimit: Decimal
    let availableLimit: Decimal
    let usedLimit: Decimal
    let details: CurrentInvoiceDetailsModel
    let spendingSummary: InvoiceSpendingSummaryModel

    var usedLimitProgress: Double {
        guard totalLimit > 0 else { return 0 }

        let value = NSDecimalNumber(decimal: usedLimit / totalLimit).doubleValue
        return min(max(value, 0), 1)
    }

    var usedLimitPercentage: Int {
        Int((usedLimitProgress * 100).rounded())
    }

    var daysUntilDueDate: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: dueDate)

        return max(calendar.dateComponents([.day], from: start, to: end).day ?? 0, 0)
    }

    var canBePaid: Bool {
        amount > 0 && status != .paid
    }
}

enum InvoiceStatus: String, Codable, Equatable {
    case open
    case closed
    case overdue
    case paid

    var title: String {
        switch self {
        case .open:
            return Strings.CurrentInvoice.Status.open
        case .closed:
            return Strings.CurrentInvoice.Status.closed
        case .overdue:
            return Strings.CurrentInvoice.Status.overdue
        case .paid:
            return Strings.CurrentInvoice.Status.paid
        }
    }

    var color: Color {
        switch self {
        case .open:
            return .brandPrimaryColor
        case .closed:
            return .textSecondaryColor
        case .overdue:
            return .red
        case .paid:
            return .green
        }
    }
}

struct CurrentInvoiceDetailsModel: Codable, Equatable {
    let purchasesSubtotal: Decimal
    let otherCharges: Decimal
    let discountsAndCredits: Decimal
    let total: Decimal
}

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
