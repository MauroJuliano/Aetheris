import Core
import Foundation
import Testing
@testable import AERegistration

@Suite("UserNameService")
struct UserNameServiceTests {
    @Test
    func submitUserName_returnsSuccess() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = UserNameService(coreService: coreService)

        let result = try await sut.submitUserName("Melissa")

        #expect(result)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/registration/user-name", method: .post)
        ])
    }

    @Test
    func submitUserName_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = UserNameService(coreService: coreService)

        do {
            _ = try await sut.submitUserName("Melissa")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
