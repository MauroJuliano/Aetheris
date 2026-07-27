import SwiftUI
import Combine

@MainActor
class MothersNameInputViewModel: ObservableObject {
    typealias localizable = Strings.MothersName
    
    @Published var isLoading: Bool = false
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    @Published var errorMessage: String?

    private let draft: RegistrationDraft
    
    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    var fieldErrorMessage: String? { errorMessage }
    
    private let service: MothersNameInputServicing
    
    init(service: MothersNameInputServicing, draft: RegistrationDraft) {
        self.service = service
        self.draft = draft
    }

    func updateMothersName(_ value: String) {
        errorMessage = nil
        draft.mothersName = RegistrationInputRules.sanitizeName(value)
    }
    
    // MARK: Life Cycle
    func submit() {
        guard RegistrationInputRules.isValidName(draft.mothersName) else {
            errorMessage = Strings.MothersName.error
            return
        }

        errorMessage = nil
        isLoading = true
        
        Task {
            do {
                _ = try await service.submitMothersName(draft.mothersName)
                submissionSucceeded.send()
            } catch {
                errorMessage = Strings.Common.errorSubmit
            }
            
            isLoading = false
        }
    }
}
