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

        #expect(sut.mothersName == "Jane Doe")
        #expect(draft.mothersName.isEmpty)
    }

    @Test
    func userName_keepsSpacesWhileTyping() {
        let draft = RegistrationDraft()
        let sut = UserNameViewModel(draft: draft)

        sut.updateUserName("Jane Doe")

        #expect(sut.userName == "Jane Doe")
        #expect(draft.userName.isEmpty)
    }
}
