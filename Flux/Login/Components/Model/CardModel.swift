import SwiftUI

struct Card {
    var content: CardContent
    
    enum CardContent {
        case creditCard(CreditCardModel)
        case info(InfoCardModel)
    }
}

struct CreditCardModel {
    let number: String
    let validDate: String
    let name: String
    let brand: String
}

struct InfoCardModel {
    let headline: String
    let title: String?
    let caption: String?
    let icon: String?
    let button: String
    let color: Color
}

