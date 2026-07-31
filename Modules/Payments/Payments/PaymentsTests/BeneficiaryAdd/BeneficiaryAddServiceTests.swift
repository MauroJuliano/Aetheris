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
            identifier: "contact@melissamccarthy.com"
        )

        #expect(beneficiary.name == "Melissa")
        #expect(beneficiary.pixKey == "contact@melissamccarthy.com")
        #expect(beneficiary.image == "melissa")
        #expect(beneficiary.hasDivider)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/beneficiaries", method: .post)
        ])
    }

    @Test(arguments: [
        "  CONTACT@MELISSAMCCARTHY.COM  ",
        "melissamccarthy",
        "MELISSA"
    ])
    func findBeneficiary_normalizesAndMatchesSupportedIdentifiers(identifier: String) {
        let beneficiary = Beneficiary(
            name: "Melissa",
            pixKey: "contact@melissamccarthy.com",
            image: "melissa",
            hasDivider: true
        )

        #expect(BeneficiaryAddService.matches(
            identifier: identifier,
            beneficiary: beneficiary
        ))
    }

    @Test
    func findBeneficiary_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = BeneficiaryAddService(coreService: coreService)

        do {
            _ = try await sut.findBeneficiary(identifier: "contact@melissamccarthy.com")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func findBeneficiary_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"beneficiaries":[]}"#.utf8)
        let sut = BeneficiaryAddService(coreService: coreService)

        do {
            _ = try await sut.findBeneficiary(identifier: "contact@melissamccarthy.com")
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func findBeneficiary_throwsNotFound_whenIdentifierIsUnknown() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = BeneficiaryAddService(coreService: coreService)

        do {
            _ = try await sut.findBeneficiary(identifier: "unknown@example.com")
            #expect(Bool(false))
        } catch {
            #expect((error as? BeneficiaryAddError) == .notFound)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func findBeneficiary_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.notConnectedToInternet)
        let sut = BeneficiaryAddService(coreService: coreService)

        do {
            _ = try await sut.findBeneficiary(identifier: "contact@melissamccarthy.com")
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .notConnectedToInternet)
            #expect(coreService.calls.count == 1)
        }
    }
}
