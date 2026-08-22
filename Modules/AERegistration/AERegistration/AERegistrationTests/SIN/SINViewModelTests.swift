import Testing
@testable import AERegistration

@MainActor
@Suite("SINViewModel")
struct SINViewModelTests {
    @Test
    func init_copiesDraftValue() {
        let draft = makeDraft()
        let sut = SINViewModel(draft: draft)

        #expect(sut.sin == draft.sin)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func updateSIN_formatsInput_andClearsError() {
        let sut = SINViewModel(draft: makeDraft())
        sut.errorMessage = Strings.Sin.error

        sut.updateSIN("12345678a9")

        #expect(sut.sin == "123.456.789")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func submit_persistsValidSIN_andCallsContinue() {
        let draft = makeDraft()
        let sut = SINViewModel(draft: draft)
        sut.updateSIN("123456789")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(didContinue)
        #expect(sut.errorMessage == nil)
        #expect(draft.sin == "123.456.789")
    }

    @Test
    func submit_rejectsInvalidSIN_withoutMutatingDraft() {
        let draft = makeDraft()
        let sut = SINViewModel(draft: draft)
        sut.updateSIN("123")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(!didContinue)
        #expect(sut.errorMessage == Strings.Sin.error)
        #expect(draft.sin == "000.000.000")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.sin = "000.000.000"
        return draft
    }
}
