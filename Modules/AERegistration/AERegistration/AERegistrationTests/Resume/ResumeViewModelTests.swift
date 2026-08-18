import Core
import Foundation
import Testing
@testable import AERegistration

@MainActor
@Suite("ResumeViewModel")
struct ResumeViewModelTests {
    @Test
    func resumeList_mapsDraftValuesInOrder() {
        let draft = makeDraft()
        let sut = ResumeViewModel(service: RegistrationResumeServiceSpy(), draft: draft)

        #expect(sut.resumeList.map(\.kind) == [
            .sin,
            .mothersName,
            .userName,
            .birthdate
        ])
        #expect(sut.resumeList.map(\.value) == [
            "123.456.789",
            "Jane Doe",
            "Melissa",
            "10/10/1999"
        ])
    }

    @Test
    func submit_sendsProfileWithSanitizedSIN_andReturnsSuccess() async {
        let service = RegistrationResumeServiceSpy()
        let draft = makeDraft()
        let sut = ResumeViewModel(service: service, draft: draft)

        let succeeded = await sut.submit()

        #expect(succeeded)
        #expect(!sut.isLoading)
        #expect(sut.submissionError == nil)
        #expect(service.profileRequests == [
            .init(
                sin: "123456789",
                mothersName: "Jane Doe",
                userName: "Melissa",
                birthdate: "10/10/1999"
            )
        ])
        #expect(service.passwordRequests.isEmpty)
    }

    @Test
    func submit_surfacesBackendErrorDescription() async {
        let backendError = CoreServiceError.badRequest(
            .init(statusCode: 400, code: "invalid_profile", message: "Profile is invalid")
        )
        let service = RegistrationResumeServiceSpy(error: backendError)
        let sut = ResumeViewModel(service: service, draft: makeDraft())

        let succeeded = await sut.submit()

        #expect(!succeeded)
        #expect(sut.submissionError == backendError)
        #expect(sut.submissionErrorDescription == "Profile is invalid")
    }

    private func makeDraft() -> RegistrationDraft {
        let draft = RegistrationDraft()
        draft.sin = "123.456.789"
        draft.mothersName = "Jane Doe"
        draft.userName = "Melissa"
        draft.birthdate = "10/10/1999"
        return draft
    }
}

private final class RegistrationResumeServiceSpy: RegistrationServicing {
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
