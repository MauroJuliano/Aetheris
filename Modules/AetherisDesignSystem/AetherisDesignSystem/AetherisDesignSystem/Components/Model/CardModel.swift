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
    }
}

public struct CreditCardTheme: Hashable {
    let gradient: [Color]
    let glow: [Color]
    let accentOverlay: Color
    let shadow: Color
    let foreground: Color
    let secondaryForeground: Color

    public init(
        gradient: [Color],
        glow: [Color],
        accentOverlay: Color,
        shadow: Color,
        foreground: Color = .white,
        secondaryForeground: Color = .white.opacity(0.7)
    ) {
        self.gradient = gradient
        self.glow = glow
        self.accentOverlay = accentOverlay
        self.shadow = shadow
        self.foreground = foreground
        self.secondaryForeground = secondaryForeground
    }
}

public enum CreditCardStyle: String, Codable, Hashable {
    case standard = "STANDARD"
    case black = "BLACK"
    case platinum = "PLATINUM"
    case gold = "GOLD"
    case aurora = "AURORA"
    case infinite = "INFINITE"

    var theme: CreditCardTheme {
        switch self {
        case .standard:
            .standard
        case .black:
            .black
        case .platinum:
            .platinum
        case .gold:
            .gold
        case .aurora:
            .aurora
        case .infinite:
            .infinite
        }
    }
}

public struct CreditCardModel: Hashable {
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

public extension CreditCardTheme {
    static let standard = CreditCardTheme(
        gradient: [
            .brandPrimaryColor,
            .brandSecondaryColor
        ],
        glow: [
            .brandPrimaryColor.opacity(0.45),
            .brandSecondaryColor.opacity(0.45)
        ],
        accentOverlay: .brandTertiaryColor.opacity(0.30),
        shadow: .brandPrimaryColor.opacity(0.18)
    )

    static let black = CreditCardTheme(
        gradient: [
            Color(hex: "#111827"),
            Color(hex: "#2D3748")
        ],
        glow: [
            .black.opacity(0.45),
            Color.gray.opacity(0.25)
        ],
        accentOverlay: .white.opacity(0.08),
        shadow: .black.opacity(0.35)
    )

    static let platinum = CreditCardTheme(
        gradient: [
            Color(hex: "#D9DCE3"),
            Color(hex: "#A7AFBF")
        ],
        glow: [
            Color.white.opacity(0.45),
            Color(hex: "#D9DCE3").opacity(0.35)
        ],
        accentOverlay: .white.opacity(0.16),
        shadow: .black.opacity(0.18),
        foreground: Color(hex: "#111827"),
        secondaryForeground: Color(hex: "#111827").opacity(0.7)
    )

    static let gold = CreditCardTheme(
        gradient: [
            Color(hex: "#D4AF37"),
            Color(hex: "#8C6A1A")
        ],
        glow: [
            Color(hex: "#D4AF37").opacity(0.40),
            Color(hex: "#8C6A1A").opacity(0.32)
        ],
        accentOverlay: .white.opacity(0.10),
        shadow: .black.opacity(0.24),
        foreground: Color(hex: "#111827"),
        secondaryForeground: Color(hex: "#111827").opacity(0.7)
    )

    static let aurora = CreditCardTheme(
        gradient: [
            .brandPrimaryColor,
            .brandTertiaryColor
        ],
        glow: [
            .brandPrimaryColor.opacity(0.42),
            .brandTertiaryColor.opacity(0.42)
        ],
        accentOverlay: .white.opacity(0.08),
        shadow: .brandTertiaryColor.opacity(0.20)
    )

    static let infinite = CreditCardTheme(
        gradient: [
            Color(hex: "#10163A"),
            Color(hex: "#312E81")
        ],
        glow: [
            Color(hex: "#10163A").opacity(0.45),
            Color(hex: "#312E81").opacity(0.45)
        ],
        accentOverlay: .white.opacity(0.08),
        shadow: Color(hex: "#10163A").opacity(0.28)
    )
}
