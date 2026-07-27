import SwiftUI
import Combine

@MainActor
class BirthdateViewModel: ObservableObject {
    typealias localizable = Strings.Birthdate
    
    @Published var isLoading: Bool = false
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    @Published var errorMessage: String?

    private let draft: RegistrationDraft
    
    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    var fieldErrorMessage: String? { errorMessage }
    
    private let service: BirthdateServicing
    
    init(service: BirthdateServicing, draft: RegistrationDraft) {
        self.service = service
        self.draft = draft
    }

    func updateBirthdate(_ value: String) {
        errorMessage = nil
        draft.birthdate = RegistrationInputRules.sanitizeBirthdate(value)
    }
    
    // MARK: Life Cycle
    func submit() {
        guard RegistrationInputRules.isValidBirthdate(draft.birthdate) else {
            errorMessage = Strings.Birthdate.error
            return
        }

        errorMessage = nil
        isLoading = true
        
        Task {
            do {
                _ = try await service.submitBirthdate(draft.birthdate)
                submissionSucceeded.send()
            } catch {
                errorMessage = Strings.Common.errorSubmit
            }
            
            isLoading = false
        }
    }
}
