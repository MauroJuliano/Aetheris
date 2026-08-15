import Foundation
import SwiftUI

@MainActor
final class PasswordViewModel: ObservableObject {
    @Published var errorMessage: String?
    private let draft: RegistrationDraft

    init(draft: RegistrationDraft) {
        self.draft = draft
    }

    var title: String { Strings.Password.title }
    var subTitle: String { Strings.Password.subTitle }
    var placeholder: String { Strings.Password.placeholder }
    var buttonName: String { Strings.Default.buttonName }

    func updatePassword(_ value: String) {
        errorMessage = nil
        draft.password = sanitize(value)
    }

    func continueTapped(onContinue: () -> Void) {
        guard draft.password.count == 4 else {
            errorMessage = Strings.Password.error
            return
        }
        errorMessage = nil
        onContinue()
    }

    private func sanitize(_ value: String) -> String {
        String(value.filter(\.isNumber).prefix(4))
    }
}
