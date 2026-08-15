import SwiftUI

@MainActor
class SINViewModel: ObservableObject {
    typealias localizable = Strings.Sin
    
    @Published var errorMessage: String?
    @Published var sin: String

    private let draft: RegistrationDraft

    init(draft: RegistrationDraft) {
        self.draft = draft
        self.sin = draft.sin
    }

    var isSINValid: Bool {
        RegistrationInputRules.isValidSIN(sin)
    }
    
    var title: String { localizable.title }
    var subtitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }

    // MARK: - Input Handling
    private func format(_ value: String) -> String {
        RegistrationInputRules.sanitizeSIN(value)
    }
    
    // MARK: - Life Cycle
    func updateSIN(_ newValue: String) {
        errorMessage = nil
        sin = format(newValue)
    }

    func submit(onContinue: () -> Void) {
        guard isSINValid else {
            errorMessage = Strings.Sin.error
            return
        }

        errorMessage = nil
        draft.sin = sin
        onContinue()
    }
}
