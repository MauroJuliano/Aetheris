import SwiftUI
import Combine

class MothersNameInputViewModel: ObservableObject {
    typealias localizable = Strings.MothersName
    
    @Published var mothersNameInput: String = ""
    @Published var isLoading: Bool = false
    let submissionSucceeded = PassthroughSubject<Void, Never>()
    
    var title: String { localizable.title }
    var subTitle: String { localizable.subTitle }
    var placeholder: String { localizable.placeholder }
    var buttonName: String { Strings.Default.buttonName }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Life Cycle
    func submit() -> AnyPublisher<Bool, Never> {
        isLoading = true
        
        // Simula call async
        return Future<Bool, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isLoading = false
                self.submissionSucceeded.send()
                promise(.success(true))
            }
        }
        .eraseToAnyPublisher()
    }
}
