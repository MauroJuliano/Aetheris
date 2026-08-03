import Core
import Foundation
import Testing
@testable import Payments

@Suite("InsuranceOnboardingService")
struct InsuranceOnboardingServiceTests {
    @Test
    func loadBenefits_returnsMockBenefits() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = InsuranceOnboardingService(coreService: coreService)

        let benefits = try await sut.loadBenefits()

        #expect(benefits.count == 4)
        #expect(benefits.map(\.text) == [
            Strings.InsuranceOnboarding.benefitOne,
            Strings.InsuranceOnboarding.benefitTwo,
            Strings.InsuranceOnboarding.benefitThree,
            Strings.InsuranceOnboarding.benefitFour
        ])
        #expect(coreService.calls == [
            .init(path: "/payments/insurance/benefits", method: .get)
        ])
    }

    @Test
    func loadBenefits_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = InsuranceOnboardingService(coreService: coreService)

        do {
            _ = try await sut.loadBenefits()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadBenefits_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"benefits":false}"#.utf8)
        let sut = InsuranceOnboardingService(coreService: coreService)

        do {
            _ = try await sut.loadBenefits()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadBenefits_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.dnsLookupFailed)
        let sut = InsuranceOnboardingService(coreService: coreService)

        do {
            _ = try await sut.loadBenefits()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .dnsLookupFailed)
            #expect(coreService.calls.count == 1)
        }
    }
}
