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

        let bullets = try await sut.loadBullets()

        #expect(bullets.count == 4)
        #expect(bullets.map(\.text) == [
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
        }
    }
}
