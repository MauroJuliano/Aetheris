import AetherisAuthenticationInterface
import Foundation
import Testing
@testable import AetherisAuthentication

@MainActor
@Suite("IdentityValidationViewModel")
struct IdentityValidationViewModelTests {
    @Test
    func fourDigits_requestValidationAndReturnAuthorization() async {
        let service = IdentityValidationServiceSpy(result: .success(.fixture))
        let sut = IdentityValidationViewModel(content: .fixture, service: service)
        let receivedAuthorization = ValueBox<IdentityAuthorization>()

        ["1", "2", "3", "4"].forEach { digit in
            sut.handleDigit(digit) { receivedAuthorization.value = $0 }
        }

        await waitForValidation(
            service: service,
            sut: sut,
            timeout: .seconds(1)
        )

        #expect(service.validatedPins == ["1234"])
        #expect(receivedAuthorization.value == .fixture)
        #expect(sut.pin.isEmpty)
        #expect(sut.validationErrorMessage == nil)
    }

    @Test
    func rejectedPin_exposesErrorWithoutLocalAttemptsOrLockout() async {
        let service = IdentityValidationServiceSpy(result: .failure(IdentityValidationError.rejected))
        let sut = IdentityValidationViewModel(content: .fixture, service: service)

        ["0", "0", "0", "0"].forEach { digit in
            sut.handleDigit(digit) { _ in }
        }
        await waitForValidation(
            service: service,
            sut: sut,
            timeout: .seconds(1)
        )

        #expect(service.validatedPins == ["0000"])
        #expect(sut.validationErrorMessage != nil)

        sut.clearError()
        #expect(sut.pin.isEmpty)
        #expect(sut.validationErrorMessage == nil)
    }

    private func waitForValidation(
        service: IdentityValidationServiceSpy,
        sut: IdentityValidationViewModel,
        timeout: Duration
    ) async {
        await Task.yield()

        let deadline = ContinuousClock.now.advanced(by: timeout)

        while (service.validatedPins.isEmpty || sut.isAuthenticating),
              ContinuousClock.now < deadline {
            await Task.yield()
            try? await Task.sleep(for: .milliseconds(5))
        }
    }

}

private final class ValueBox<Value> {
    var value: Value?
}

private final class IdentityValidationServiceSpy: IdentityValidationServicing {
    let result: Result<IdentityAuthorization, Error>
    private(set) var validatedPins: [String] = []

    init(result: Result<IdentityAuthorization, Error>) {
        self.result = result
    }

    func validate(pin: String) async throws -> IdentityAuthorization {
        validatedPins.append(pin)
        return try result.get()
    }
}

private extension IdentityAuthorization {
    static let fixture = IdentityAuthorization(token: "authorization-token", expiresAt: "later")
}

private extension IdentityValidationContent {
    static let fixture = IdentityValidationContent(
        navigationTitle: "Confirm",
        title: "Enter PIN",
        description: "Confirm your identity"
    )
}
