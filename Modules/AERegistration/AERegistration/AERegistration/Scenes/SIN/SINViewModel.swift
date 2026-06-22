import SwiftUI
import Combine

@MainActor
class SINViewModel: ObservableObject {
    typealias localizable = Strings.Sin
    
    @Published var isLoading: Bool = false
    @Published private(set) var rawSIN: String = ""
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    @Published var errorMessage: String?
    @Published private(set) var sin: String = ""
    
    var isSINValid: Bool {
        rawSIN.count == 9
    }
    
    var title: String { localizable.title }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    
    private let service: SINServiceProtocol
    
    init(service: SINServiceProtocol) {
        self.service = service
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input Handling
    private func format(_ value: String) -> String {
        let trimmed = String(value.prefix(9)) // SIN tem 9 dígitos
        
        var result = ""
        
        for (index, digit) in trimmed.enumerated() {
            if index == 3 || index == 6 {
                result.append(" ")
            }
            result.append(digit)
        }
        
        return result
    }
    
    // MARK: - Life Cycle
    func updateSIN(_ newValue: String) {
        let digitsOnly = newValue.filter { $0.isNumber }
        sin = format(digitsOnly)
    }
    
    func submit() {
       
        
        isLoading = true
        
        Task {
            do {
                let success = try await service.submitSIN(rawSIN)
                submissionSucceeded.send()
            } catch {
                errorMessage = "Failed to submit"
            }
            
            isLoading = false
        }
    }
}
