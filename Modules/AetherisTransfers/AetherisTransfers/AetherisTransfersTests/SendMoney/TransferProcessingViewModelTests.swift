import Foundation
import Testing
@testable import AetherisTransfers

@MainActor
@Suite("TransferProcessingViewModel")
struct TransferProcessingViewModelTests {
    @Test
    func submit_mapsBackendResponseToReceipt() async {
        let service = SubmissionServiceSpy(results: [.success(.fixture)])
        let sut = TransferProcessingViewModel(submission: .fixture, service: service)
        var receivedReceipt: TransferReceiptModel?

        await sut.submit { receivedReceipt = $0 }

        #expect(service.submissions == [.fixture])
        #expect(receivedReceipt?.referenceId == TransferReceiptResponse.fixture.referenceId)
        #expect(receivedReceipt?.recipientName == TransferReceiptResponse.fixture.recipientName)
    }

    @Test
    func retry_reusesSameIdempotencyKeyAfterFailure() async {
        let service = SubmissionServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success(.fixture)
        ])
        let sut = TransferProcessingViewModel(submission: .fixture, service: service)
        var receivedReceipt: TransferReceiptModel?

        await sut.submit { receivedReceipt = $0 }
        guard case .failed = sut.state else {
            Issue.record("Expected failed state")
            return
        }

        await sut.submit { receivedReceipt = $0 }

        #expect(service.submissions.count == 2)
        #expect(service.submissions.map(\.idempotencyKey) == ["idempotency-key", "idempotency-key"])
        #expect(receivedReceipt != nil)
    }

    @Test
    func submit_ignoresDuplicateRequestWhileOneIsInFlight() async {
        let service = SubmissionServiceSpy(results: [.success(.fixture)], delay: .milliseconds(30))
        let sut = TransferProcessingViewModel(submission: .fixture, service: service)

        async let first: Void = sut.submit { _ in }
        await Task.yield()
        async let duplicate: Void = sut.submit { _ in }
        _ = await (first, duplicate)

        #expect(service.submissions.count == 1)
    }
}

private final class SubmissionServiceSpy: SendMoneyServicing {
    private var results: [Result<TransferReceiptResponse, Error>]
    private let delay: Duration?
    private(set) var submissions: [TransferSubmission] = []

    init(results: [Result<TransferReceiptResponse, Error>], delay: Duration? = nil) {
        self.results = results
        self.delay = delay
    }

    func loadSession() async throws -> SendMoneySession { .mock }
    func validate(pin: String) async throws -> IdentityAuthorization { .fixture }

    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse {
        submissions.append(submission)
        if let delay { try await Task.sleep(for: delay) }
        return try results.removeFirst().get()
    }
}

extension TransferReceiptModel {
    static let fixture = TransferReceiptModel(
        amount: "$ 10.00",
        recipientName: "Melissa",
        recipientEmail: "melissa@example.com",
        accountName: "Main Account",
        accountLastDigits: "1234",
        date: "Today",
        referenceId: "TRX123"
    )
}

extension TransferDraft {
    static let fixture = TransferDraft(
        amount: 10,
        formattedAmount: "$ 10.00",
        currency: "USD",
        beneficiaryName: "Melissa",
        beneficiaryIdentifier: "melissa@example.com",
        accountName: "Main Account",
        accountLastDigits: "1234"
    )
}

extension IdentityAuthorization {
    static let fixture = IdentityAuthorization(token: "authorization-token", expiresAt: "later")
}

extension TransferSubmission {
    static let fixture = TransferSubmission(
        draft: .fixture,
        authorization: .fixture,
        idempotencyKey: "idempotency-key"
    )
}

extension TransferReceiptResponse {
    static let fixture = TransferReceiptResponse(
        transactionId: "transaction-id",
        referenceId: "TRX-123",
        status: "completed",
        amount: 10,
        currency: "USD",
        recipientName: "Melissa",
        recipientIdentifier: "melissa@example.com",
        accountName: "Main Account",
        accountLastDigits: "1234",
        completedAt: "Today"
    )
}
