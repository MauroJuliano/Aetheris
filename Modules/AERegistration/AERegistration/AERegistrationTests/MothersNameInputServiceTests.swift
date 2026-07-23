import Core
import Foundation
import Testing
@testable import AERegistration

@Suite("MothersNameInputService")
struct MothersNameInputServiceTests {
    @Test
    func submitMothersName_returnsRegisterModel() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = MothersNameInputService(coreService: coreService)

        let result = try await sut.submitMothersName("Jane Doe")

        #expect(result.mothersName == "Jane Doe")
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/registration/mothers-name", method: .post)
        ])
    }

    @Test
    func submitMothersName_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = MothersNameInputService(coreService: coreService)

        do {
            _ = try await sut.submitMothersName("Jane Doe")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
