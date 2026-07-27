import SwiftUI
import Combine

@MainActor
class UserNameViewModel: ObservableObject {
    typealias localizable = Strings.UserName
    
    @Published var isLoading: Bool = false
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    @Published var errorMessage: String?

    private let draft: RegistrationDraft
    
    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    var fieldErrorMessage: String? { errorMessage }
    
    private let service: UserNameServicing
    
    init(service: UserNameServicing, draft: RegistrationDraft) {
        self.service = service
        self.draft = draft
    }

    func updateUserName(_ value: String) {
        errorMessage = nil
        draft.userName = RegistrationInputRules.sanitizeName(value)
    }
    
    // MARK: Life cycle
    func submit() {
        guard RegistrationInputRules.isValidName(draft.userName) else {
            errorMessage = Strings.UserName.error
            return
        }

        errorMessage = nil
        isLoading = true
        
        Task {
            do {
                _ = try await service.submitUserName(draft.userName)
                submissionSucceeded.send()
            } catch {
                errorMessage = Strings.Common.errorSubmit
            }
            
            isLoading = false
        }
    }
}
