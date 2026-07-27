import Core
import Foundation
import Testing
@testable import AERegistration

@Suite("BirthdateService")
struct BirthdateServiceTests {
    @Test
    func submitBirthdate_returnsSuccess() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BirthdateService(coreService: coreService)

        let result = try await sut.submitBirthdate("10/10/1999")

        #expect(result)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/registration/birthdate", method: .post)
        ])
    }

    @Test
    func submitBirthdate_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = BirthdateService(coreService: coreService)

        do {
            _ = try await sut.submitBirthdate("10/10/1999")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
