import Core
import Foundation
import Testing
@testable import Payments

@Suite("CardInsuranceService")
struct CardInsuranceServiceTests {
    @Test
    func loadBullets_returnsMockBullets() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = CardInsuranceService(coreService: coreService)

        let response = try await sut.loadBullets()

        #expect(response.bullets.count == 4)
        #expect(response.bullets.map(\.text) == [
            Strings.CardInsurance.bulletOne,
            Strings.CardInsurance.bulletTwo,
            Strings.CardInsurance.bulletThree,
            Strings.CardInsurance.bulletFour
        ])
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/card-insurance/bullets", method: .get)
        ])
    }

    @Test
    func loadBullets_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = CardInsuranceService(coreService: coreService)

        do {
            _ = try await sut.loadBullets()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadBullets_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"bullets":42}"#.utf8)
        let sut = CardInsuranceService(coreService: coreService)

        do {
            _ = try await sut.loadBullets()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadBullets_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.cannotParseResponse)
        let sut = CardInsuranceService(coreService: coreService)

        do {
            _ = try await sut.loadBullets()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .cannotParseResponse)
            #expect(coreService.calls.count == 1)
        }
    }
}
