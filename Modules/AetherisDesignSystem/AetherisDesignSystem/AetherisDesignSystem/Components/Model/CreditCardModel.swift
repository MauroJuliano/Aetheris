import Foundation

public struct CreditCardModel: Hashable, Codable {
    let number: String
    let validDate: String
    let name: String
    let brand: String
    let style: CreditCardStyle

    public init(
        number: String,
        validDate: String,
        name: String,
        brand: String,
        style: CreditCardStyle = .standard
    ) {
        self.number = number
        self.validDate = validDate
        self.name = name
        self.brand = brand
        self.style = style
    }
}
