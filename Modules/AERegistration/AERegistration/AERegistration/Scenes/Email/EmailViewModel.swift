import SwiftUI

@MainActor
final class EmailViewModel: ObservableObject {
    typealias localizable = Strings.Email

    @Published var errorMessage: String?
    @Published var email: String

    private let draft: RegistrationDraft

    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    var fieldErrorMessage: String? { errorMessage }

    init(draft: RegistrationDraft) {
        self.draft = draft
        self.email = draft.email
    }

    func updateEmail(_ value: String) {
        errorMessage = nil
        email = RegistrationInputRules.sanitizeEmail(value)
    }

    func submit(onContinue: () -> Void) {
        guard RegistrationInputRules.isValidEmail(email) else {
            errorMessage = Strings.Email.error
            return
        }

        errorMessage = nil
        draft.email = RegistrationInputRules.sanitizeEmail(email)
        onContinue()
    }
}
