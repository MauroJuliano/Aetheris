import Core
import Foundation
import Testing
@testable import Payments

@Suite("SendMoneyService")
struct SendMoneyServiceTests {
    @Test
    func loadSession_returnsMockSession() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = SendMoneyService(coreService: coreService)

        let session = try await sut.loadSession()

        #expect(session.wallet.currency == "USD")
        #expect(session.wallet.balance == 1_000.00)
        #expect(session.wallet.available == 1_000.00)
        #expect(session.account.name == "Main Account")
        #expect(session.account.lastDigits == "1234")
        #expect(session.limits.dailyLimit == 2_500.00)
        #expect(session.limits.remainingDailyLimit == 1_810.00)
        #expect(session.fees.count == 1)
        #expect(session.securityMessage.contains("biometrics"))
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/send-money/session", method: .get)
        ])
    }

    @Test
    func loadSession_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = SendMoneyService(coreService: coreService)

        do {
            _ = try await sut.loadSession()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadSession_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"wallet":[]}"#.utf8)
        let sut = SendMoneyService(coreService: coreService)

        do {
            _ = try await sut.loadSession()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadSession_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.timedOut)
        let sut = SendMoneyService(coreService: coreService)

        do {
            _ = try await sut.loadSession()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .timedOut)
            #expect(coreService.calls.count == 1)
        }
    }
}
