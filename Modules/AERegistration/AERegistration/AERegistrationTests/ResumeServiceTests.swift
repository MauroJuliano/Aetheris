import Core
import Foundation
import Testing
@testable import AERegistration

@Suite("ResumeService")
struct ResumeServiceTests {
    @Test
    func completeRegistration_returnsSuccess() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = ResumeService(coreService: coreService)
        let request = RegistrationCompletionRequest(
            sin: "000000000",
            mothersName: "Jane Doe",
            userName: "Melissa",
            birthdate: "10/10/1999",
            password: "1234"
        )

        let result = try await sut.completeRegistration(request)

        #expect(result)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/registration/complete", method: .post)
        ])
    }

    @Test
    func completeRegistration_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = ResumeService(coreService: coreService)
        let request = RegistrationCompletionRequest(
            sin: "000000000",
            mothersName: "Jane Doe",
            userName: "Melissa",
            birthdate: "10/10/1999",
            password: "1234"
        )

        do {
            _ = try await sut.completeRegistration(request)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
