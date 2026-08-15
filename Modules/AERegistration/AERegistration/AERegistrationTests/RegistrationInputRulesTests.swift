import Foundation
import Testing
@testable import AERegistration

@Suite("RegistrationInputRules")
struct RegistrationInputRulesTests {
    @Test
    func sanitizeSIN_formatsWhileTyping_andLimitsToNineDigits() {
        #expect(RegistrationInputRules.sanitizeSIN("0") == "0")
        #expect(RegistrationInputRules.sanitizeSIN("0000") == "000.0")
        #expect(RegistrationInputRules.sanitizeSIN("0000000") == "000.000.0")
        #expect(RegistrationInputRules.sanitizeSIN("0000000000") == "000.000.000")
    }

    @Test
    func sanitizeBirthdate_formatsWhileTyping_andLimitsToEightDigits() {
        #expect(RegistrationInputRules.sanitizeBirthdate("1") == "1")
        #expect(RegistrationInputRules.sanitizeBirthdate("10") == "10")
        #expect(RegistrationInputRules.sanitizeBirthdate("101") == "10/1")
        #expect(RegistrationInputRules.sanitizeBirthdate("1010") == "10/10")
        #expect(RegistrationInputRules.sanitizeBirthdate("10101") == "10/10/1")
        #expect(RegistrationInputRules.sanitizeBirthdate("101010101") == "10/10/1010")
    }

    @Test
    func sanitizeName_keepsInternalSpaces_whileTyping() {
        #expect(RegistrationInputRules.sanitizeName("Jane doe") == "Jane doe")
        #expect(RegistrationInputRules.sanitizeName("Jane   doe") == "Jane doe")
        #expect(RegistrationInputRules.normalizedName("  Jane doe  ") == "Jane doe")
    }
}
