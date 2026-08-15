//
//  AetherisDesignSystemTests.swift
//  AetherisDesignSystemTests
//
//  Created by maclau on 24/02/26.
//

import Foundation
import Testing
@testable import AetherisDesignSystem

@MainActor
struct AetherisDesignSystemTests {
    @Test
    func transferAmount_acceptsDigitsAsCentsAndDeletesLastDigit() {
        let sut = TransferAmountViewModel(balance: 100)

        sut.handleKeyPress("1")
        sut.handleKeyPress("2")
        sut.handleKeyPress("3")

        #expect(sut.currentAmount == Decimal(string: "1.23"))

        sut.handleKeyPress("delete.left")

        #expect(sut.currentAmount == Decimal(string: "0.12"))
    }

    @Test
    func transferAmount_capsInputAndCurrentAmountWhenBalanceDecreases() {
        let sut = TransferAmountViewModel(balance: 10)

        ["9", "9", "9", "9"].forEach(sut.handleKeyPress)

        #expect(sut.currentAmount == Decimal(10))

        sut.updateBalance(4.50)

        #expect(sut.currentAmount == Decimal(string: "4.50"))
        #expect(sut.balance == Decimal(string: "4.50"))
    }

    @Test
    func transferAmount_ignoresUnsupportedKeys() {
        let sut = TransferAmountViewModel(balance: 100)

        sut.handleKeyPress("A")
        sut.handleKeyPress(".")

        #expect(sut.currentAmount == 0)
    }
}
