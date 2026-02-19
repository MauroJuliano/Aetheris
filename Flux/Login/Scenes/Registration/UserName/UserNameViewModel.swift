import SwiftUI
import Combine

class UserNameViewModel: ObservableObject {
    typealias localizable = Strings.UserName
    
    @Published var userName: String = ""
    @Published var isLoading: Bool = false
    @Published var submissionSuccess: Bool? = nil
    @Published var errorMessage: String?
    
    var title: String { localizable.title }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    
    private let service: UserNameServicing
    
    init(service: UserNameServicing) {
        self.service = service
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Life cycle
    func submit() {
        isLoading = true
        
        Task {
            do {
                let success = try await service.submitUserName(userName)
                submissionSuccess = success
            } catch {
                errorMessage = "Failed to submit"
            }
            
            isLoading = false
        }
    }
}
