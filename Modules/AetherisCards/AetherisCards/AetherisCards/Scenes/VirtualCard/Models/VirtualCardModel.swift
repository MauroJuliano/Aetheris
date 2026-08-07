import AetherisDesignSystem
import Foundation

enum CardBrand: String, Codable, Equatable {
    case visa = "VISA"
    case mastercard = "MASTERCARD"
    case elo = "ELO"
}

struct VirtualCardModel: Identifiable, Codable, Equatable {
    let id: UUID
    let physicalCardId: UUID
    let holderName: String
    let cardNumber: String
    let expirationDate: String
    let securityCode: String
    let brand: CardBrand
    let style: CreditCardStyle
    let availableLimit: Decimal
    let totalLimit: Decimal
    let monthlyExpenses: Decimal
    let isActive: Bool

    var lastFourDigits: String {
        String(cardNumber.suffix(4))
    }

    var maskedNumber: String {
        "•••• •••• •••• \(lastFourDigits)"
    }

    var formattedNumber: String {
        cardNumber.chunked(into: 4).joined(separator: " ")
    }

    var usedLimitProgress: Double {
        guard totalLimit > 0 else { return 0 }

        let usedLimit = max(totalLimit - availableLimit, 0)
        return min(
            max(NSDecimalNumber(decimal: usedLimit / totalLimit).doubleValue, 0),
            1
        )
    }

    var monthlyUsagePercentage: Int {
        guard totalLimit > 0 else { return 0 }

        let percentage = NSDecimalNumber(decimal: monthlyExpenses / totalLimit * 100).doubleValue
        return Int(percentage.rounded())
    }
}
