import Testing
@testable import AERegistration

@MainActor
@Suite("MothersNameInputViewModel")
struct MothersNameInputViewModelTests {
    @Test
    func init_copiesDraftValue() {
        let draft = makeDraft()
        let sut = MothersNameInputViewModel(draft: draft)

        #expect(sut.mothersName == draft.mothersName)
        #expect(sut.fieldErrorMessage == nil)
    }

    @Test
    func updateMothersName_sanitizesInternalSpaces_andClearsError() {
        let sut = MothersNameInputViewModel(draft: makeDraft())
        sut.errorMessage = Strings.MothersName.error

        sut.updateMothersName("Jane   doe")

        #expect(sut.mothersName == "Jane doe")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func submit_persistsNormalizedName_andCallsContinue() {
        let draft = makeDraft()
        let sut = MothersNameInputViewModel(draft: draft)
        sut.updateMothersName("  Jane   doe  ")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(didContinue)
        #expect(sut.errorMessage == nil)
        #expect(draft.mothersName == "Jane doe")
    }

    @Test
    func submit_rejectsInvalidName_withoutMutatingDraft() {
        let draft = makeDraft()
        let sut = MothersNameInputViewModel(draft: draft)
        sut.updateMothersName("1")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(!didContinue)
        #expect(sut.errorMessage == Strings.MothersName.error)
        #expect(draft.mothersName == "Mary Johnson")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.mothersName = "Mary Johnson"
        return draft
    }
}
