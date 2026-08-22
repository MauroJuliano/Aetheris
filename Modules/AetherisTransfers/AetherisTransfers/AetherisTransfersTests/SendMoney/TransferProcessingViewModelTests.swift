import Core
import AetherisAuthenticationInterface
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
        let service = DeferredSubmissionService(result: .success(.fixture))
        let sut = TransferProcessingViewModel(submission: .fixture, service: service)

        async let first: Void = sut.submit { _ in }
        await service.waitUntilCalled()

        async let duplicate: Void = sut.submit { _ in }
        await Task.yield()
        await service.finish()
        _ = await (first, duplicate)

        #expect(await service.submissions.count == 1)
    }

    @Test
    func submit_exposesBackendMessage_whenServiceFailsWithCoreError() async {
        let service = SubmissionServiceSpy(
            results: [
                .failure(
                    CoreServiceError.badRequest(
                        .init(
                            statusCode: 400,
                            message: "Recipient not available"
                        )
                    )
                )
            ]
        )
        let sut = TransferProcessingViewModel(submission: .fixture, service: service)

        await sut.submit { _ in }

        guard case let .failed(message) = sut.state else {
            Issue.record("Expected failed state")
            return
        }

        #expect(message == "Recipient not available")
    }

    @Test
    func submit_usesFallbackMessage_whenServiceFailsWithoutBackendMessage() async {
        let service = SubmissionServiceSpy(results: [.failure(URLError(.timedOut))])
        let sut = TransferProcessingViewModel(submission: .fixture, service: service)

        await sut.submit { _ in }

        guard case let .failed(message) = sut.state else {
            Issue.record("Expected failed state")
            return
        }

        #expect(message == Strings.TransferProcessing.errorDescription)
    }
}

private final class SubmissionServiceSpy: SendMoneyServicing {
    private var results: [Result<TransferReceiptResponse, Error>]
    private(set) var submissions: [TransferSubmission] = []

    init(results: [Result<TransferReceiptResponse, Error>]) {
        self.results = results
    }

    func loadSession() async throws -> SendMoneySession { .mock }
    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse {
        submissions.append(submission)
        guard !results.isEmpty else {
            throw SubmissionServiceSpyError.exhaustedResults
        }

        return try results.removeFirst().get()
    }
}

private enum SubmissionServiceSpyError: Error {
    case exhaustedResults
}

private actor DeferredSubmissionService: SendMoneyServicing {
    private let result: Result<TransferReceiptResponse, Error>
    private var continuation: CheckedContinuation<Void, Never>?
    private(set) var submissions: [TransferSubmission] = []

    init(result: Result<TransferReceiptResponse, Error>) {
        self.result = result
    }

    func loadSession() async throws -> SendMoneySession { .mock }

    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse {
        submissions.append(submission)

        await withCheckedContinuation { continuation in
            self.continuation = continuation
        }

        return try result.get()
    }

    func waitUntilCalled() async {
        while submissions.isEmpty {
            await Task.yield()
        }
    }

    func finish() {
        continuation?.resume()
        continuation = nil
    }
}

extension TransferReceiptModel {
    static let fixture = TransferReceiptModel(
        amount: "$ 10.00",
        recipientName: "Sophie Keller",
        recipientEmail: "sophie.keller@aetheris.app",
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
        beneficiaryName: "Sophie Keller",
        beneficiaryIdentifier: "sophie.keller@aetheris.app",
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
        recipientName: "Sophie Keller",
        recipientIdentifier: "sophie.keller@aetheris.app",
        accountName: "Main Account",
        accountLastDigits: "1234",
        completedAt: "Today"
    )
}
