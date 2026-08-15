import Core
import Foundation
import Testing
@testable import AetherisTransfers

@Suite("BeneficiaryListService")
struct BeneficiaryListServiceTests {
    @Test
    func loadBeneficiaryList_returnsMockPayload() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryListService(coreService: coreService)

        let response = try await sut.loadBeneficiaryList()

        #expect(response.beneficiaries.count == BeneficiaryFixtures.defaults.count)
        #expect(response.beneficiaries.first?.name == "Sophie Keller")
        #expect(coreService.calls == [
            .init(path: "/payments/beneficiaries/recent", method: .get)
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
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadBeneficiaryList_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"beneficiaries":"invalid"}"#.utf8)
        let sut = BeneficiaryListService(coreService: coreService)

        do {
            _ = try await sut.loadBeneficiaryList()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
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
            #expect(coreService.calls.count == 1)
        }
    }
}
