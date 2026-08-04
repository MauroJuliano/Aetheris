import Core
import Foundation
import SwiftUI

@MainActor
final class ConfirmPasswordViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    @Published var submissionError: CoreServiceError?

    private let draft: RegistrationDraft
    private let service: any RegistrationServicing

    init(service: any RegistrationServicing, draft: RegistrationDraft) {
        self.service = service
        self.draft = draft
    }

    var title: String { Strings.ConfirmPassword.title }
    var subTitle: String { Strings.ConfirmPassword.subTitle }
    var placeholder: String { Strings.ConfirmPassword.placeholder }
    var buttonName: String { Strings.Default.buttonName }

    func updateConfirmPassword(_ value: String) {
        errorMessage = nil
        draft.confirmPassword = sanitize(value)
    }

    @discardableResult
    func submit() async -> Bool {
        guard !isLoading else { return false }

        guard draft.confirmPassword.count == 4 else {
            errorMessage = Strings.Password.error
            return false
        }

        guard draft.confirmPassword == draft.password else {
            errorMessage = Strings.ConfirmPassword.Error.mismatch
            return false
        }

        isLoading = true
        errorMessage = nil
        submissionError = nil
        defer { isLoading = false }

        do {
            let succeeded = try await service.submitPassword(
                RegistrationPasswordRequest(password: draft.password)
            )
            if !succeeded {
                submissionError = .invalidResponse
            } else {
                draft.clearPasswords()
            }
            return succeeded
        } catch {
            submissionError = (error as? CoreServiceError) ?? .invalidResponse
            return false
        }
    }

    var submissionErrorDescription: String {
        submissionError?.serverMessage ?? Strings.SubmissionError.description
    }

    private func sanitize(_ value: String) -> String {
        String(value.filter(\.isNumber).prefix(4))
    }
}
