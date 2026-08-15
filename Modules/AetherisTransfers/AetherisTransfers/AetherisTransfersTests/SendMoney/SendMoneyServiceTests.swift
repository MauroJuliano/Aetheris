import Core
import Foundation
import Testing
@testable import AetherisTransfers

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
        #expect(coreService.calls == [
            .init(path: "/payments/send-money/session", method: .get)
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

    @Test
    func submitTransfer_postsWithIdempotencyKeyAndReturnsBackendReceipt() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = SendMoneyService(coreService: coreService)
        let submission = TransferSubmission.fixture

        let receipt = try await sut.submit(submission)

        #expect(receipt.transactionId == submission.idempotencyKey)
        #expect(receipt.recipientName == submission.draft.beneficiaryName)
        #expect(coreService.calls == [
            .init(
                path: "/payments/transfers",
                method: .post,
                headers: ["Idempotency-Key": submission.idempotencyKey]
            )
        ])
    }
}
