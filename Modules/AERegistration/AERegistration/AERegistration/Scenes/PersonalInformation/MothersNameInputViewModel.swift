import SwiftUI

@MainActor
class MothersNameInputViewModel: ObservableObject {
    typealias localizable = Strings.MothersName
    
    @Published var errorMessage: String?
    @Published var mothersName: String

    private let draft: RegistrationDraft
    
    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    var fieldErrorMessage: String? { errorMessage }
    
    init(draft: RegistrationDraft) {
        self.draft = draft
        self.mothersName = draft.mothersName
    }

    func updateMothersName(_ value: String) {
        errorMessage = nil
        mothersName = RegistrationInputRules.sanitizeName(value)
    }
    
    // MARK: Life Cycle
    func submit(onContinue: () -> Void) {
        guard RegistrationInputRules.isValidName(mothersName) else {
            errorMessage = Strings.MothersName.error
            return
        }

        errorMessage = nil
        draft.mothersName = mothersName
        onContinue()
    }
}
