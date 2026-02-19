import SwiftUI
import Combine

@MainActor
class SINViewModel: ObservableObject {
    typealias localizable = Strings.Sin
    
    @Published var isLoading: Bool = false
    @Published private(set) var rawSIN: String = ""
    @Published var submissionSuccess: Bool? = nil
    @Published var errorMessage: String?

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
  
    func updateSIN(_ value: String) {
        rawSIN = String(
            value
                .filter(\.isNumber)
                .prefix(9)
        )
    }

    func formattedSIN() -> String {
        var result = ""
        for (index, digit) in rawSIN.enumerated() {
            if index == 3 || index == 6 {
                result.append(" ")
            }
            result.append(digit)
        }
        return result
    }

    // MARK: - Life Cycle
    func submit() {
        guard rawSIN.count == 9 else { return }
        
        isLoading = true
        
        Task {
            do {
                let success = try await service.submitSIN(rawSIN)
                submissionSuccess = success
            } catch {
                errorMessage = "Failed to submit"
            }
            
            isLoading = false
        }
    }
}
