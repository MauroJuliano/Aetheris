import AetherisAuthenticationInterface
import Core
import Testing
@testable import AetherisAuthentication

@Suite("IdentityValidationService")
struct IdentityValidationServiceTests {
    @Test
    func validPin_returnsBackendAuthorization() async throws {
        let sut = IdentityValidationService(coreService: DemoCoreService(delay: 0))

        let authorization = try await sut.validate(pin: "1234")

        #expect(authorization.token == "demo-transfer-authorization")
    }

    @Test
    func rejectedPin_throwsRejected() async {
        let sut = IdentityValidationService(coreService: DemoCoreService(delay: 0))

        await #expect(throws: IdentityValidationError.rejected) {
            try await sut.validate(pin: "0000")
        }
    }
}
