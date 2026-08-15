import Core
import Foundation
import Testing
@testable import AetherisTransfers

@Suite("BeneficiaryDetailsService")
struct BeneficiaryDetailsServiceTests {
    @Test
    func fetchBeneficiaryDetails_returnsMockPayloadForSelectedBeneficiary() async throws {
        let beneficiary = BeneficiaryFixtures.defaults[1]
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryDetailsService(coreService: coreService)

        let details = try await sut.fetchBeneficiaryDetails(beneficiaryId: beneficiary.id)

        #expect(details.id == beneficiary.id)
        #expect(details.name == beneficiary.name)
        #expect(details.information.accountInformation == beneficiary.pixKey)
        #expect(details.recentTransactions.count == 3)
        #expect(coreService.calls == [
            .init(
                path: "/payments/beneficiaries/\(beneficiary.id.uuidString)",
                method: .get
            )
        ])
    }

    @Test
    func removeBeneficiary_postsRemoveEndpoint() async throws {
        let beneficiary = BeneficiaryFixtures.defaults[0]
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryDetailsService(coreService: coreService)

        try await sut.removeBeneficiary(beneficiaryId: beneficiary.id)

        #expect(coreService.calls == [
            .init(
                path: "/payments/beneficiaries/\(beneficiary.id.uuidString)/remove",
                method: .post
            )
        ])
    }

    @Test
    func fetchBeneficiaryDetails_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = BeneficiaryDetailsService(coreService: coreService)

        do {
            _ = try await sut.fetchBeneficiaryDetails(beneficiaryId: BeneficiaryFixtures.defaults[0].id)
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }
}
