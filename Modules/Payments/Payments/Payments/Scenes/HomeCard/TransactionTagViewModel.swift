import SwiftUI

enum TransactionType {
    case income
    case expense
    case transfer

    var title: String {
        switch self {
        case .income: "Income"
        case .expense: "Expense"
        case .transfer: "Transfer"
        }
    }

    var color: Color {
        switch self {
        case .income: .green
        case .expense: .red
        case .transfer: .purple
        }
    }

    var icon: String {
        switch self {
        case .income: "arrow.down"
        case .expense: "arrow.up"
        case .transfer: "arrow.up.right"
        }
    }
}


