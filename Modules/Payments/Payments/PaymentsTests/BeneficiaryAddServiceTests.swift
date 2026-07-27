import Core
import Foundation
import Testing
@testable import Payments

@Suite("BeneficiaryAddService")
struct BeneficiaryAddServiceTests {
    @Test
    func findBeneficiary_returnsMatchedBeneficiary() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryAddService(coreService: coreService)

        let beneficiary = try await sut.findBeneficiary(
            identifier: "beneficiary@example.com"
        )

        #expect(!beneficiary.name.isEmpty)
        #expect(beneficiary.pixKey == "beneficiary@example.com")
        #expect(!beneficiary.image.isEmpty)
        #expect(beneficiary.hasDivider)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/beneficiaries", method: .post)
        ])
    }

    @Test
    func findBeneficiary_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = BeneficiaryAddService(coreService: coreService)

        do {
            _ = try await sut.findBeneficiary(identifier: "beneficiary@example.com")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    @Test
    func findBeneficiary_usesFallbackMock_whenIdentifierIsUnknown() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryAddService(coreService: coreService)

        let beneficiary = try await sut.findBeneficiary(identifier: "unknown@example.com")

        #expect(!beneficiary.name.isEmpty)
        #expect(beneficiary.pixKey == "unknown@example.com")
    }
}
