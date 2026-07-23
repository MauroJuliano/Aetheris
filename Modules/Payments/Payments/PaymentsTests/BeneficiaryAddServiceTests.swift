import Core
import Foundation
import Testing
@testable import Payments

@Suite("BeneficiaryAddService")
struct BeneficiaryAddServiceTests {
    @Test
    func createBeneficiary_returnsCreatedBeneficiary() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryAddService(coreService: coreService)

        let beneficiary = try await sut.createBeneficiary(
            name: "New Beneficiary",
            pixKey: "beneficiary@example.com",
            image: "melissa"
        )

        #expect(beneficiary.name == "New Beneficiary")
        #expect(beneficiary.pixKey == "beneficiary@example.com")
        #expect(beneficiary.image == "melissa")
        #expect(beneficiary.hasDivider)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/beneficiaries", method: .post)
        ])
    }

    @Test
    func createBeneficiary_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = BeneficiaryAddService(coreService: coreService)

        do {
            _ = try await sut.createBeneficiary(
                name: "New Beneficiary",
                pixKey: "beneficiary@example.com",
                image: "melissa"
            )
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }
}
