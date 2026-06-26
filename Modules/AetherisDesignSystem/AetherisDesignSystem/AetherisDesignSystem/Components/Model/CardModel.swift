import SwiftUI

public struct Card: Identifiable, Hashable {
    public var id: UUID
    var content: CardContent
    
    public init(id: UUID = UUID(),
                content: CardContent) {
        self.id = id
        self.content = content
    }
    
    public enum CardContent: Hashable {
        case creditCard(CreditCardModel)
        case info(InfoCardModel)
    }
}

public struct CreditCardModel: Hashable {
    let number: String
    let validDate: String
    let name: String
    let brand: String
    
    public init(number: String, validDate: String, name: String, brand: String) {
        self.number = number
        self.validDate = validDate
        self.name = name
        self.brand = brand
    }
}

public struct InfoCardModel: Hashable {
    let headline: String
    let title: String?
    let caption: String?
    let icon: String?
    let button: String
    let color: Color
    
    public init(headline: String, title: String?, caption: String?, icon: String?, button: String, color: Color) {
        self.headline = headline
        self.title = title
        self.caption = caption
        self.icon = icon
        self.button = button
        self.color = color
    }
}

