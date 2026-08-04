import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("TransferPinViewModel")
struct TransferPinViewModelTests {
    @Test
    func fourDigits_requestIdentityValidationAndReturnAuthorization() async {
        let service = TransferServiceSpy(validationResult: .success(.fixture))
        let sut = TransferPinViewModel(draft: .fixture, service: service)
        var receivedAuthorization: IdentityAuthorization?

        ["1", "2", "3", "4"].forEach { digit in
            sut.handleDigit(digit) { receivedAuthorization = $0 }
        }
        await waitForAsyncWork()

        #expect(service.validatedPins == ["1234"])
        #expect(receivedAuthorization == .fixture)
        #expect(sut.pin.isEmpty)
        #expect(sut.validationErrorMessage == nil)
    }

    @Test
    func rejectedPin_exposesErrorWithoutLocalAttemptsOrLockout() async {
        let service = TransferServiceSpy(validationResult: .failure(IdentityValidationError.rejected))
        let sut = TransferPinViewModel(draft: .fixture, service: service)

        ["0", "0", "0", "0"].forEach { digit in
            sut.handleDigit(digit) { _ in }
        }
        await waitForAsyncWork()

        #expect(service.validatedPins == ["0000"])
        #expect(sut.validationErrorMessage != nil)

        sut.clearError()
        #expect(sut.pin.isEmpty)
        #expect(sut.validationErrorMessage == nil)
    }

    private func waitForAsyncWork() async {
        try? await Task.sleep(for: .milliseconds(20))
    }
}

private final class TransferServiceSpy: SendMoneyServicing {
    let validationResult: Result<IdentityAuthorization, Error>
    private(set) var validatedPins: [String] = []

    init(validationResult: Result<IdentityAuthorization, Error>) {
        self.validationResult = validationResult
    }

    func loadSession() async throws -> SendMoneySession { .mock }

    func validate(pin: String) async throws -> IdentityAuthorization {
        validatedPins.append(pin)
        return try validationResult.get()
    }

    func submit(_ submission: TransferSubmission) async throws -> TransferReceiptResponse {
        .fixture
    }
}
