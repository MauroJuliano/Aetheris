import Foundation
import LocalAuthentication
import SwiftUI

@MainActor
final class TransferPinViewModel: ObservableObject {
    @Published private(set) var pin = ""
    @Published private(set) var isError = false
    @Published private(set) var attemptsLeft: Int
    @Published private(set) var biometricErrorMessage: String?
    @Published private(set) var canUseFaceID: Bool

    let receipt: TransferReceiptModel
    let correctPin: String
    let pinLimit: Int

    init(
        receipt: TransferReceiptModel,
        correctPin: String = "1234",
        attemptsLeft: Int = 2,
        pinLimit: Int = 4
    ) {
        self.receipt = receipt
        self.correctPin = correctPin
        self.attemptsLeft = attemptsLeft
        self.pinLimit = pinLimit

        let context = LAContext()
        var evaluationError: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &evaluationError)
        self.canUseFaceID = canEvaluate && context.biometryType == .faceID
    }

    var title: String {
        "Enter your PIN"
    }

    var subtitle: String {
        "Enter your \(pinLimit)-digit PIN to send\n\(receipt.amount) to \(receipt.recipientName)."
    }

    var isLockedOut: Bool {
        attemptsLeft == 0
    }

    var dotColor: Color {
        isError ? .error : .brandPrimaryColor
    }

    var lockColor: Color {
        isError ? .error : .brandPrimaryColor
    }

    var lockBackgroundColor: Color {
        isError ? Color.error.opacity(0.10) : Color.brandPrimaryColor.opacity(0.10)
    }

    func handleDigit(_ digit: String, onValidPin: () -> Void) {
        guard pin.count < pinLimit, !isLockedOut else { return }

        if isError {
            isError = false
            pin = ""
        }

        pin.append(digit)

        if pin.count == pinLimit {
            validatePin(onValidPin: onValidPin)
        }
    }

    func deleteDigit() {
        guard !pin.isEmpty else { return }
        pin.removeLast()
        isError = false
    }

    func authenticateWithFaceID(onValidPin: @escaping () -> Void) {
        guard canUseFaceID else {
            biometricErrorMessage = Strings.TransferPin.faceIDUnavailable
            return
        }

        biometricErrorMessage = nil

        let context = LAContext()
        context.localizedCancelTitle = Strings.Common.back

        var evaluationError: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &evaluationError),
              context.biometryType == .faceID else {
            biometricErrorMessage = Strings.TransferPin.faceIDUnavailable
            canUseFaceID = false
            return
        }

        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: Strings.TransferPin.faceIDReason
        ) { [weak self] success, error in
            Task { @MainActor in
                guard let self else { return }

                if success {
                    self.reset()
                    onValidPin()
                    return
                }

                if let laError = error as? LAError,
                   laError.code == .userCancel ||
                   laError.code == .systemCancel ||
                   laError.code == .appCancel {
                    return
                }

                self.biometricErrorMessage = error?.localizedDescription ?? Strings.TransferPin.faceIDFailed
            }
        }
    }

    func reset() {
        pin = ""
        isError = false
    }

    private func validatePin(onValidPin: () -> Void) {
        if pin == correctPin {
            onValidPin()
        } else {
            isError = true
            attemptsLeft = max(0, attemptsLeft - 1)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
                self?.pin = ""
            }
        }
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
}
