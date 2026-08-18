import Testing
@testable import AERegistration

@MainActor
@Suite("PasswordViewModel")
struct PasswordViewModelTests {
    @Test
    func updatePassword_filtersToFourDigits() {
        let draft = makeDraft()
        let sut = PasswordViewModel(draft: draft)
        sut.errorMessage = Strings.Password.error

        sut.updatePassword("12a345")

        #expect(draft.password == "1234")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func continueTapped_rejectsInvalidPassword() {
        let draft = makeDraft()
        let sut = PasswordViewModel(draft: draft)

        var didContinue = false
        sut.continueTapped {
            didContinue = true
        }

        #expect(!didContinue)
        #expect(sut.errorMessage == Strings.Password.error)
    }

    @Test
    func continueTapped_allowsValidPassword() {
        let draft = makeDraft()
        let sut = PasswordViewModel(draft: draft)
        sut.updatePassword("1234")

        var didContinue = false
        sut.continueTapped {
            didContinue = true
        }

        #expect(didContinue)
        #expect(sut.errorMessage == nil)
        #expect(draft.password == "1234")
    }

    private func makeDraft() -> RegistrationDraft {
        RegistrationDraft()
    }
}
