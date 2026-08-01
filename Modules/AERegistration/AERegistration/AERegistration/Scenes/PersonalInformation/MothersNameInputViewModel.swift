import SwiftUI

@MainActor
class MothersNameInputViewModel: ObservableObject {
    typealias localizable = Strings.MothersName
    
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

    func updateMothersName(_ value: String) {
        errorMessage = nil
        draft.mothersName = RegistrationInputRules.sanitizeName(value)
    }
    
    // MARK: Life Cycle
    func submit(onContinue: () -> Void) {
        guard RegistrationInputRules.isValidName(draft.mothersName) else {
            errorMessage = Strings.MothersName.error
            return
        }

        errorMessage = nil
        onContinue()
    }
}
