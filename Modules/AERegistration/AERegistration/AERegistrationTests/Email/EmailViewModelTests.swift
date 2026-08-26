import Testing
@testable import AERegistration

@MainActor
@Suite("EmailViewModel")
struct EmailViewModelTests {
    @Test
    func init_copiesDraftValue() {
        let draft = makeDraft()
        let sut = EmailViewModel(draft: draft)

        #expect(sut.email == draft.email)
        #expect(sut.fieldErrorMessage == nil)
    }

    @Test
    func updateEmail_sanitizesValue_andClearsError() {
        let sut = EmailViewModel(draft: makeDraft())
        sut.errorMessage = Strings.Email.error

        sut.updateEmail("  Jane.Doe@Example.com ")

        #expect(sut.email == "jane.doe@example.com")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func submit_persistsNormalizedEmail_andCallsContinue() {
        let draft = makeDraft()
        let sut = EmailViewModel(draft: draft)
        sut.updateEmail("  Jane.Doe@Example.com ")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(didContinue)
        #expect(sut.errorMessage == nil)
        #expect(draft.email == "jane.doe@example.com")
    }

    @Test
    func submit_rejectsInvalidEmail_withoutMutatingDraft() {
        let draft = makeDraft()
        let sut = EmailViewModel(draft: draft)
        sut.updateEmail("jane")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(!didContinue)
        #expect(sut.errorMessage == Strings.Email.error)
        #expect(draft.email == "jane@example.com")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.email = "jane@example.com"
        return draft
    }
}
