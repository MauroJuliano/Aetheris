import SwiftUI

@MainActor
class UserNameViewModel: ObservableObject {
    typealias localizable = Strings.UserName
    
    @Published var errorMessage: String?

    private let draft: RegistrationDraft
    
    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    var fieldErrorMessage: String? { errorMessage }
    
    init(draft: RegistrationDraft) {
        self.draft = draft
    }

    func updateUserName(_ value: String) {
        errorMessage = nil
        draft.userName = value
    }
    
    // MARK: Life cycle
    func submit(onContinue: () -> Void) {
        guard RegistrationInputRules.isValidName(draft.userName) else {
            errorMessage = Strings.UserName.error
            return
        }

        errorMessage = nil
        onContinue()
    }
}
