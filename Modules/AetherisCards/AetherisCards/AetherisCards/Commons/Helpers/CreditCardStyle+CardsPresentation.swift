import AetherisDesignSystem
import SwiftUI

extension CreditCardStyle {
    var cardsGradientColors: [Color] {
        switch self {
        case .standard:
            return [.brandPrimaryColor, .brandSecondaryColor]
        case .black:
            return [Color(hex: "#111827"), Color(hex: "#2D3748")]
        case .platinum:
            return [Color(hex: "#D9DCE3"), Color(hex: "#A7AFBF")]
        case .gold:
            return [Color(hex: "#D4AF37"), Color(hex: "#8C6A1A")]
        case .aurora:
            return [.brandPrimaryColor, .brandTertiaryColor]
        case .infinite:
            return [Color(hex: "#10163A"), Color(hex: "#312E81")]
        }
    }

    var cardsAccentOverlay: Color {
        switch self {
        case .standard:
            return .brandTertiaryColor.opacity(0.30)
        case .black, .aurora, .infinite:
            return .white.opacity(0.08)
        case .platinum:
            return .white.opacity(0.16)
        case .gold:
            return .white.opacity(0.10)
        }
    }

    var cardsShadowColor: Color {
        switch self {
        case .standard:
            return .brandPrimaryColor.opacity(0.18)
        case .black:
            return .black.opacity(0.35)
        case .platinum:
            return .black.opacity(0.18)
        case .gold:
            return .black.opacity(0.24)
        case .aurora:
            return .brandTertiaryColor.opacity(0.20)
        case .infinite:
            return Color(hex: "#10163A").opacity(0.28)
        }
    }

    var cardsForegroundColor: Color {
        switch self {
        case .platinum, .gold:
            return Color(hex: "#111827")
        case .standard, .black, .aurora, .infinite:
            return .white
        }
    }

    var cardsSecondaryForegroundColor: Color {
        cardsForegroundColor.opacity(0.72)
    }
}
