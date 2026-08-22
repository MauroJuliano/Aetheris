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

    @Test
    func sanitizeEmail_trimsSpaces_andLowercases() {
        #expect(RegistrationInputRules.sanitizeEmail("  Jane.Doe@Example.com ") == "jane.doe@example.com")
    }

    @Test
    func isValidSIN_requiresExpectedMask() {
        #expect(!RegistrationInputRules.isValidSIN(""))
        #expect(!RegistrationInputRules.isValidSIN("123456789"))
        #expect(RegistrationInputRules.isValidSIN("123.456.789"))
        #expect(!RegistrationInputRules.isValidSIN("123.456.7890"))
    }

    @Test
    func isValidBirthdate_requiresExpectedMaskAndRealDate() {
        #expect(!RegistrationInputRules.isValidBirthdate(""))
        #expect(!RegistrationInputRules.isValidBirthdate("10/10/10"))
        #expect(RegistrationInputRules.isValidBirthdate("10/10/2010"))
        #expect(!RegistrationInputRules.isValidBirthdate("31/02/2010"))
    }

    @Test
    func isValidName_requiresMinimumVisibleCharacters() {
        #expect(!RegistrationInputRules.isValidName(" "))
        #expect(!RegistrationInputRules.isValidName("J"))
        #expect(RegistrationInputRules.isValidName("Jane"))
        #expect(RegistrationInputRules.isValidName("Jane Doe"))
    }

    @Test
    func isValidEmail_requiresStandardFormat() {
        #expect(!RegistrationInputRules.isValidEmail(""))
        #expect(!RegistrationInputRules.isValidEmail("jane"))
        #expect(RegistrationInputRules.isValidEmail("jane.doe@example.com"))
        #expect(RegistrationInputRules.isValidEmail("JANE.DOE@EXAMPLE.COM"))
    }
}
