import Foundation
import SwiftUI

@MainActor
public final class TransferAmountViewModel: ObservableObject {
    @Published private var digits: String = ""

    public let balance: Decimal

    public var formattedAmount: String {
        formatCurrency(currentAmount)
    }

    public var formattedBalance: String {
        formatCurrency(balance)
    }

    public var currentAmount: Decimal {
        guard let cents = Decimal(string: digits), !digits.isEmpty else {
            return 0
        }

        return cents / 100
    }

    public init(balance: Decimal) {
        self.balance = balance
    }

    public func handleKeyPress(_ key: String) {
        switch key {
        case "delete.left":
            removeLastDigit()

        case ".":
            return

        default:
            appendDigit(key)
        }
    }

    private func appendDigit(_ key: String) {
        guard key.allSatisfy(\.isNumber) else { return }

        let newDigits = digits + key

        guard let cents = Decimal(string: newDigits) else { return }

        let newAmount = cents / 100

        if newAmount <= balance {
            digits = newDigits
        } else {
            digits = balanceAsDigits
        }
    }

    private func removeLastDigit() {
        guard !digits.isEmpty else { return }
        digits.removeLast()
    }

    private var balanceAsDigits: String {
        let cents = balance * 100
        return NSDecimalNumber(decimal: cents).intValue.description
    }

    private func formatCurrency(_ value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        return formatter.string(from: NSDecimalNumber(decimal: value)) ?? "$0.00"
    }
}
