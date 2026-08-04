import Core
import Foundation
import Testing
@testable import AERegistration

@MainActor
@Suite("Registration submission")
struct RegistrationSubmissionViewModelTests {
    @Test
    func draft_startsEmptyAndResetsEveryField() {
        let draft = makeDraft()

        draft.reset()

        #expect(draft.sin.isEmpty)
        #expect(draft.mothersName.isEmpty)
        #expect(draft.userName.isEmpty)
        #expect(draft.birthdate.isEmpty)
        #expect(draft.password.isEmpty)
        #expect(draft.confirmPassword.isEmpty)
    }

    @Test
    func resumeSubmit_sendsOnlyProfileDataAndReturnsSuccess() async {
        let service = RegistrationServiceSpy()
        let draft = makeDraft()
        let sut = ResumeViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(succeeded)
        #expect(!sut.isLoading)
        #expect(sut.submissionError == nil)
        #expect(service.profileRequests == [
            .init(
                sin: "000000000",
                mothersName: "Jane Doe",
                userName: "Melissa",
                birthdate: "10/10/1999"
            )
        ])
        #expect(service.passwordRequests.isEmpty)
    }

    @Test
    func resumeSubmit_showsSheetAndPreservesDraft_whenRequestFails() async {
        let backendError = CoreServiceError.badRequest(
            .init(statusCode: 400, code: "invalid_profile", message: "Profile is invalid")
        )
        let service = RegistrationServiceSpy(error: backendError)
        let draft = makeDraft()
        let sut = ResumeViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(!sut.isLoading)
        #expect(sut.submissionError == backendError)
        #expect(sut.submissionErrorDescription == "Profile is invalid")
        #expect(draft.sin == "000.000.000")
        #expect(draft.password == "1234")
    }

    @Test
    func resumeSubmit_showsSheet_whenBackendRejectsProfile() async {
        let service = RegistrationServiceSpy(result: false)
        let sut = ResumeViewModel(service: service, draft: makeDraft())

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(sut.submissionError == .invalidResponse)
    }

    @Test
    func confirmPassword_rejectsMismatchWithoutRequest() async {
        let service = RegistrationServiceSpy()
        let draft = makeDraft()
        draft.confirmPassword = "4321"
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(sut.errorMessage == Strings.ConfirmPassword.Error.mismatch)
        #expect(service.passwordRequests.isEmpty)
    }

    @Test
    func confirmPassword_sendsOnlyPasswordAndReturnsSuccess() async {
        let service = RegistrationServiceSpy()
        let draft = makeDraft()
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(succeeded)
        #expect(!sut.isLoading)
        #expect(sut.submissionError == nil)
        #expect(service.passwordRequests == [.init(password: "1234")])
        #expect(service.profileRequests.isEmpty)
        #expect(draft.password.isEmpty)
        #expect(draft.confirmPassword.isEmpty)
    }

    @Test
    func confirmPassword_preservesPasswords_whenBackendRejectsRequest() async {
        let service = RegistrationServiceSpy(result: false)
        let draft = makeDraft()
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(draft.password == "1234")
        #expect(draft.confirmPassword == "1234")
    }

    @Test
    func confirmPassword_showsSheetAndPreservesPasswords_whenRequestFails() async {
        let service = RegistrationServiceSpy(error: URLError(.cannotConnectToHost))
        let draft = makeDraft()
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(sut.submissionError == .invalidResponse)
        #expect(draft.password == "1234")
        #expect(draft.confirmPassword == "1234")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.sin = "000.000.000"
        draft.mothersName = "Jane Doe"
        draft.userName = "Melissa"
        draft.birthdate = "10/10/1999"
        draft.password = "1234"
        draft.confirmPassword = "1234"
        return draft
    }
}

private final class RegistrationServiceSpy: RegistrationServicing {
    private(set) var profileRequests: [RegistrationProfileRequest] = []
    private(set) var passwordRequests: [RegistrationPasswordRequest] = []
    private let error: Error?
    private let result: Bool

    init(error: Error? = nil, result: Bool = true) {
        self.error = error
        self.result = result
    }

    func submitProfile(_ request: RegistrationProfileRequest) async throws -> Bool {
        profileRequests.append(request)
        if let error { throw error }
        return result
    }

    func submitPassword(_ request: RegistrationPasswordRequest) async throws -> Bool {
        passwordRequests.append(request)
        if let error { throw error }
        return result
    }
}
