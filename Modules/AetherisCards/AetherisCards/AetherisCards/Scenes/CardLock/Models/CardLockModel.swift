import AetherisDesignSystem
import Foundation

struct CardLockModel: Identifiable, Codable, Equatable {
    let id: UUID
    let holderName: String
    let lastFourDigits: String
    let expirationDate: String
    let brand: CardBrand
    let style: CreditCardStyle
    let isBlocked: Bool

    var maskedNumber: String {
        "•••• •••• •••• \(lastFourDigits)"
    }

    func updating(isBlocked: Bool) -> CardLockModel {
        CardLockModel(
            id: id,
            holderName: holderName,
            lastFourDigits: lastFourDigits,
            expirationDate: expirationDate,
            brand: brand,
            style: style,
            isBlocked: isBlocked
        )
    }
}
