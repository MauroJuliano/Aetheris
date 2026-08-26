import Testing
@testable import AERegistration

@MainActor
@Suite("UserNameViewModel")
struct UserNameViewModelTests {
    @Test
    func init_copiesDraftValue() {
        let draft = makeDraft()
        let sut = UserNameViewModel(draft: draft)

        #expect(sut.userName == draft.userName)
        #expect(sut.fieldErrorMessage == nil)
    }

    @Test
    func updateUserName_sanitizesInternalSpaces_andClearsError() {
        let sut = UserNameViewModel(draft: makeDraft())
        sut.errorMessage = Strings.UserName.error

        sut.updateUserName("Jane   doe")

        #expect(sut.userName == "Jane doe")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func submit_persistsNormalizedName_andCallsContinue() {
        let draft = makeDraft()
        let sut = UserNameViewModel(draft: draft)
        sut.updateUserName("  Jane   doe  ")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(didContinue)
        #expect(sut.errorMessage == nil)
        #expect(draft.userName == "Jane doe")
    }

    @Test
    func submit_rejectsInvalidName_withoutMutatingDraft() {
        let draft = makeDraft()
        let sut = UserNameViewModel(draft: draft)
        sut.updateUserName("1")

        var didContinue = false
        sut.submit {
            didContinue = true
        }

        #expect(!didContinue)
        #expect(sut.errorMessage == Strings.UserName.error)
        #expect(draft.userName == "Melissa")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.userName = "Melissa"
        return draft
    }
}
