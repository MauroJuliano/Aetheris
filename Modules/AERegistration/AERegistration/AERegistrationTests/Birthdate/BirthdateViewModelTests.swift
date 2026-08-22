import Testing
@testable import AERegistration

@MainActor
@Suite("BirthdateViewModel")
struct BirthdateViewModelTests {
    @Test
    func init_copiesDraftValue() {
        let draft = makeDraft()
        let sut = BirthdateViewModel(draft: draft)

        #expect(sut.birthdate == draft.birthdate)
        #expect(sut.fieldErrorMessage == nil)
    }

    @Test
    func updateBirthdate_formatsInput_andClearsError() {
        let sut = BirthdateViewModel(draft: makeDraft())
        sut.errorMessage = Strings.Birthdate.error

        sut.updateBirthdate("10101")

        #expect(sut.birthdate == "10/10/1")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func submit_persistsValidBirthdate_andCallsContinue() {
        let draft = makeDraft()
        let sut = BirthdateViewModel(draft: draft)
        sut.updateBirthdate("10101999")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(didContinue)
        #expect(sut.errorMessage == nil)
        #expect(draft.birthdate == "10/10/1999")
    }

    @Test
    func submit_rejectsInvalidBirthdate_withoutMutatingDraft() {
        let draft = makeDraft()
        let sut = BirthdateViewModel(draft: draft)
        sut.updateBirthdate("10101")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(!didContinue)
        #expect(sut.errorMessage == Strings.Birthdate.error)
        #expect(draft.birthdate == "12/10/1980")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.birthdate = "12/10/1980"
        return draft
    }
}
