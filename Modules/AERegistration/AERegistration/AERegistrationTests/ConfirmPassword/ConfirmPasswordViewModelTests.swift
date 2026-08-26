import Core
import Foundation
import Testing
@testable import AERegistration

@MainActor
@Suite("ConfirmPasswordViewModel")
struct ConfirmPasswordViewModelTests {
    @Test
    func updateConfirmPassword_filtersToFourDigits_andClearsError() {
        let draft = makeDraft()
        let sut = ConfirmPasswordViewModel(service: RegistrationConfirmPasswordServiceSpy(), draft: draft)
        sut.errorMessage = Strings.ConfirmPassword.Error.mismatch

        sut.updateConfirmPassword("12a345")

        #expect(draft.confirmPassword == "1234")
        #expect(sut.errorMessage == nil)
    }

    @Test
    func submit_rejectsMismatchedPassword_withoutRequest() async {
        let service = RegistrationConfirmPasswordServiceSpy()
        let draft = makeDraft()
        draft.confirmPassword = "4321"
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(sut.errorMessage == Strings.ConfirmPassword.Error.mismatch)
        #expect(service.passwordRequests.isEmpty)
    }

    @Test
    func submit_sendsPasswordAndClearsDraft_onSuccess() async {
        let service = RegistrationConfirmPasswordServiceSpy()
        let draft = makeDraft()
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(succeeded)
        #expect(!sut.isLoading)
        #expect(sut.submissionError == nil)
        #expect(service.passwordRequests == [.init(password: "1234")])
        #expect(draft.password.isEmpty)
        #expect(draft.confirmPassword.isEmpty)
    }

    @Test
    func submit_surfacesBackendErrorDescription() async {
        let backendError = CoreServiceError.badRequest(
            .init(statusCode: 400, code: "invalid_password", message: "Password is invalid")
        )
        let service = RegistrationConfirmPasswordServiceSpy(error: backendError)
        let draft = makeDraft()
        let sut = ConfirmPasswordViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(sut.submissionError == backendError)
        #expect(sut.submissionErrorDescription == "Password is invalid")
        #expect(draft.password == "1234")
        #expect(draft.confirmPassword == "1234")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.password = "1234"
        draft.confirmPassword = "1234"
        return draft
    }
}

private final class RegistrationConfirmPasswordServiceSpy: RegistrationServicing {
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
