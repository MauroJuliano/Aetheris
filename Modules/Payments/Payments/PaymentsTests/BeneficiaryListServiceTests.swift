import Core
import Foundation
import Testing
@testable import Payments

@Suite("BeneficiaryListService")
struct BeneficiaryListServiceTests {
    @Test
    func loadBeneficiaryList_returnsMockPayload() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryListService(coreService: coreService)

        let response = try await sut.loadBeneficiaryList()

        #expect(response.beneficiaries.count == Beneficiary.mock.count)
        #expect(response.beneficiaries.first?.name == "Melissa")
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/beneficiaries/recent", method: .get)
        ])
    }

    @Test
    func loadBeneficiaryList_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = BeneficiaryListService(coreService: coreService)

        do {
            _ = try await sut.loadBeneficiaryList()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    @Test
    func loadBeneficiaryList_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.notConnectedToInternet)
        let sut = BeneficiaryListService(coreService: coreService)

        do {
            _ = try await sut.loadBeneficiaryList()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .notConnectedToInternet)
        }
    }
}
