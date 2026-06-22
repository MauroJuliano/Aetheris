import SwiftUI
import Combine

class BirthdateViewModel: ObservableObject {
    typealias localizable = Strings.Birthdate
    
    @Published var birthdate: String = ""
    @Published var isLoading: Bool = false
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    @Published var errorMessage: String?
    
    var title: String { localizable.title }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let service: BirthdateServicing
    
    init(service: BirthdateServicing) {
        self.service = service
    }
    
    // MARK: Life Cycle
    func submit() {
        isLoading = true
        
        Task {
            do {
                let success = try await service.submitBirthdate(birthdate)
                submissionSucceeded.send()
            } catch {
                errorMessage = "Failed to submit"
            }
            
            isLoading = false
        }
    }
}
