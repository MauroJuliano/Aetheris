import SwiftUI

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
