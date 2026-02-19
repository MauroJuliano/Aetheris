import SwiftUI

struct Card: Identifiable, Hashable {
    var id: UUID = UUID()
    var content: CardContent
    
    enum CardContent: Hashable {
        case creditCard(CreditCardModel)
        case info(InfoCardModel)
    }
}

struct CreditCardModel: Hashable {
    let number: String
    let validDate: String
    let name: String
    let brand: String
}

struct InfoCardModel: Hashable {
    let headline: String
    let title: String?
    let caption: String?
    let icon: String?
    let button: String
    let color: Color
}

