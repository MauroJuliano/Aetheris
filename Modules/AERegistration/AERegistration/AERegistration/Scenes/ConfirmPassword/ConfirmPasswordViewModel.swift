import Core
import Foundation
import SwiftUI

@MainActor
final class ConfirmPasswordViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let draft: RegistrationDraft
    private let service: ResumeServicing

    init(service: ResumeServicing, draft: RegistrationDraft) {
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

    func submit(onSuccess: @escaping () -> Void) {
        guard draft.confirmPassword.count == 4 else {
            errorMessage = Strings.Password.error
            return
        }

        guard draft.confirmPassword == draft.password else {
            errorMessage = Strings.ConfirmPassword.Error.mismatch
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let request = RegistrationCompletionRequest(
                    sin: draft.sin.filter(\.isNumber),
                    mothersName: draft.mothersName,
                    userName: draft.userName,
                    birthdate: draft.birthdate,
                    password: draft.password
                )
                _ = try await service.completeRegistration(request)
                await MainActor.run {
                    onSuccess()
                }
            } catch {
                await MainActor.run {
                    errorMessage = Strings.Common.errorSubmit
                }
            }

            await MainActor.run {
                isLoading = false
            }
        }
    }

    private func sanitize(_ value: String) -> String {
        String(value.filter(\.isNumber).prefix(4))
    }
}
