import SwiftUI

@MainActor
class BirthdateViewModel: ObservableObject {
    typealias localizable = Strings.Birthdate
    
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

    func updateBirthdate(_ value: String) {
        errorMessage = nil
        draft.birthdate = RegistrationInputRules.sanitizeBirthdate(value)
    }
    
    // MARK: Life Cycle
    func submit(onContinue: () -> Void) {
        guard RegistrationInputRules.isValidBirthdate(draft.birthdate) else {
            errorMessage = Strings.Birthdate.error
            return
        }

        errorMessage = nil
        onContinue()
    }
}
