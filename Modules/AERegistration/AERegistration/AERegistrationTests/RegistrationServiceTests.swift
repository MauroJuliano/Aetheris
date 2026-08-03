import Core
import Foundation
import Testing
@testable import AERegistration

@Suite("RegistrationService")
struct RegistrationServiceTests {
    @Test
    func submitProfile_postsProfileEndpoint() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = RegistrationService(coreService: coreService)
        let request = RegistrationProfileRequest(
            sin: "000000000",
            mothersName: "Jane Doe",
            userName: "Melissa",
            birthdate: "10/10/1999"
        )

        let result = try await sut.submitProfile(request)

        #expect(result)
        #expect(coreService.calls == [
            .init(path: "/registration/profile", method: .post)
        ])
    }

    @Test
    func submitPassword_postsPasswordEndpoint() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = RegistrationService(coreService: coreService)

        let result = try await sut.submitPassword(.init(password: "1234"))

        #expect(result)
        #expect(coreService.calls == [
            .init(path: "/registration/password", method: .post)
        ])
    }

    @Test(arguments: [RegistrationRequest.profile, .password])
    func submit_propagatesCoreServiceErrors(request: RegistrationRequest) async {
        let coreService = CoreServiceTestDouble()
        coreService.error = CoreServiceError.invalidResponse
        let sut = RegistrationService(coreService: coreService)

        do {
            switch request {
            case .profile:
                _ = try await sut.submitProfile(.mock)
            case .password:
                _ = try await sut.submitPassword(.init(password: "1234"))
            }
            Issue.record("Expected request to throw")
        } catch {
            #expect((error as? CoreServiceError) == .invalidResponse)
        }
    }
}

enum RegistrationRequest: CaseIterable {
    case profile
    case password
}

extension RegistrationProfileRequest {
    fileprivate static let mock = Self(
        sin: "000000000",
        mothersName: "Jane Doe",
        userName: "Melissa",
        birthdate: "10/10/1999"
    )
}
