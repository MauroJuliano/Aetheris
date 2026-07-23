import Core
import Foundation
import Testing
@testable import AERegistration

@Suite("SINService")
struct SINServiceTests {
    @Test
    func submitSIN_returnsSuccess() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = SINService(coreService: coreService)

        let result = try await sut.submitSIN("000000000")

        #expect(result)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/registration/sin", method: .post)
        ])
    }

    @Test
    func submitSIN_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = SINService(coreService: coreService)

        do {
            _ = try await sut.submitSIN("000000000")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
