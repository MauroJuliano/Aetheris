import Combine
import Foundation
import SwiftUI

@MainActor
public final class TransferAmountViewModel: ObservableObject {
    @Published private var digits: String = ""
    @Published public private(set) var currentAmount: Decimal = 0

    @Published public private(set) var balance: Decimal

    public var formattedAmount: String {
        formatCurrency(currentAmount)
    }

    public var formattedBalance: String {
        formatCurrency(balance)
    }

    public init(balance: Decimal) {
        self.balance = balance
    }

    public func updateBalance(_ balance: Decimal) {
        self.balance = balance
        if currentAmount > balance {
            currentAmount = balance
            digits = balanceAsDigits
        }
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
            currentAmount = newAmount
        } else {
            digits = balanceAsDigits
            currentAmount = balance
        }
    }

    private func removeLastDigit() {
        guard !digits.isEmpty else { return }
        digits.removeLast()
        currentAmount = amount(from: digits)
    }

    private var balanceAsDigits: String {
        let cents = balance * 100
        return NSDecimalNumber(decimal: cents).intValue.description
    }

    private func amount(from digits: String) -> Decimal {
        guard let cents = Decimal(string: digits), !digits.isEmpty else {
            return 0
        }

        return cents / 100
    }

    private func formatCurrency(_ value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        return formatter.string(from: NSDecimalNumber(decimal: value)) ?? "USD 0.00"
    }
}
