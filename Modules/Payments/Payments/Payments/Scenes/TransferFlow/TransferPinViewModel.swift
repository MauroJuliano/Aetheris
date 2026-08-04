import Core
import Foundation
import SwiftUI

@MainActor
final class TransferPinViewModel: ObservableObject {
    @Published private(set) var pin = ""
    @Published private(set) var isAuthenticating = false
    @Published private(set) var validationErrorMessage: String?

    let draft: TransferDraft
    let pinLimit: Int

    private let service: any SendMoneyServicing

    init(
        draft: TransferDraft,
        service: any SendMoneyServicing,
        pinLimit: Int = 4
    ) {
        self.draft = draft
        self.service = service
        self.pinLimit = pinLimit
    }

    var dotColor: Color { .brandPrimaryColor }
    var lockColor: Color { .brandPrimaryColor }
    var lockBackgroundColor: Color { Color.brandPrimaryColor.opacity(0.10) }

    func handleDigit(
        _ digit: String,
        onAuthorized: @escaping (IdentityAuthorization) -> Void
    ) {
        guard pin.count < pinLimit, !isAuthenticating else { return }
        pin.append(digit)

        guard pin.count == pinLimit else { return }
        Task { await validate(onAuthorized: onAuthorized) }
    }

    func deleteDigit() {
        guard !pin.isEmpty, !isAuthenticating else { return }
        pin.removeLast()
    }

    func clearError() {
        validationErrorMessage = nil
        pin = ""
    }

    func letters(for number: String) -> String {
        switch number {
        case "2": "ABC"
        case "3": "DEF"
        case "4": "GHI"
        case "5": "JKL"
        case "6": "MNO"
        case "7": "PQRS"
        case "8": "TUV"
        case "9": "WXYZ"
        default: ""
        }
    }

    private func validate(onAuthorized: @escaping (IdentityAuthorization) -> Void) async {
        guard !isAuthenticating else { return }
        isAuthenticating = true
        validationErrorMessage = nil
        defer { isAuthenticating = false }

        do {
            let authorization = try await service.validate(pin: pin)
            pin = ""
            onAuthorized(authorization)
        } catch {
            validationErrorMessage = Self.message(for: error)
        }
    }

    private static func message(for error: Error) -> String {
        if let coreError = error as? CoreServiceError,
           let message = coreError.serverMessage {
            return message
        }
        return Strings.TransferPin.validationErrorDescription
    }
}
