import Testing
@testable import AERegistration

@MainActor
@Suite("Registration name inputs")
struct RegistrationNameInputTests {
    @Test
    func mothersName_keepsSpacesWhileTyping() {
        let draft = RegistrationDraft()
        let sut = MothersNameInputViewModel(draft: draft)

        sut.updateMothersName("Jane Doe")

        #expect(draft.mothersName == "Jane Doe")
    }

    @Test
    func userName_keepsSpacesWhileTyping() {
        let draft = RegistrationDraft()
        let sut = UserNameViewModel(draft: draft)

        sut.updateUserName("Jane Doe")

        #expect(draft.userName == "Jane Doe")
    }
}
