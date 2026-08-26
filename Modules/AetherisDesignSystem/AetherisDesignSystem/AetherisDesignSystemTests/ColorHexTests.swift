import Foundation
import Testing
import UIKit
import SwiftUI
@testable import AetherisDesignSystem

@Suite("ColorHex")
struct ColorHexTests {
    @Test
    func initializer_parsesThreeSixAndEightDigitHexValues() {
        assertColor(
            Color(hex: "#ABC"),
            red: 170,
            green: 187,
            blue: 204,
            alpha: 255
        )

        assertColor(
            Color(hex: "#112233"),
            red: 17,
            green: 34,
            blue: 51,
            alpha: 255
        )

        assertColor(
            Color(hex: "#80112233"),
            red: 17,
            green: 34,
            blue: 51,
            alpha: 128
        )
    }

    @Test
    func initializer_fallsBackToOpaqueBlack_forUnsupportedValues() {
        assertColor(
            Color(hex: "not-a-color"),
            red: 0,
            green: 0,
            blue: 0,
            alpha: 255
        )
    }

    private func assertColor(
        _ color: Color,
        red: Int,
        green: Int,
        blue: Int,
        alpha: Int
    ) {
        let uiColor = UIColor(color)
        var actualRed: CGFloat = 0
        var actualGreen: CGFloat = 0
        var actualBlue: CGFloat = 0
        var actualAlpha: CGFloat = 0

        let extracted = uiColor.getRed(
            &actualRed,
            green: &actualGreen,
            blue: &actualBlue,
            alpha: &actualAlpha
        )

        #expect(extracted)
        #expect(Int(round(actualRed * 255)) == red)
        #expect(Int(round(actualGreen * 255)) == green)
        #expect(Int(round(actualBlue * 255)) == blue)
        #expect(Int(round(actualAlpha * 255)) == alpha)
    }
}
