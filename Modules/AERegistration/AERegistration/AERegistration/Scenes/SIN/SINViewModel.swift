import SwiftUI
import Combine

@MainActor
class SINViewModel: ObservableObject {
    typealias localizable = Strings.Sin
    
    @Published var isLoading: Bool = false
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    @Published var errorMessage: String?

    private let draft: RegistrationDraft
    private let service: SINServiceProtocol

    init(service: SINServiceProtocol, draft: RegistrationDraft) {
        self.service = service
        self.draft = draft
    }

    var isSINValid: Bool {
        RegistrationInputRules.isValidSIN(draft.sin)
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
        draft.sin = format(newValue)
    }

    func submit() {
        guard isSINValid else {
            errorMessage = Strings.Sin.error
            return
        }

        errorMessage = nil
        isLoading = true
        
        Task {
            do {
                _ = try await service.submitSIN(draft.sin.filter(\.isNumber))
                submissionSucceeded.send()
            } catch {
                errorMessage = Strings.Common.errorSubmit
            }
            
            isLoading = false
        }
    }
}
