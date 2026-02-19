import SwiftUI

protocol SINServiceProtocol {
    func submitSIN(_ sin: String) async throws -> Bool
}

final class MockSINService: SINServiceProtocol {
    
    var shouldFail: Bool = false
    var delay: TimeInterval = 1.5
    
    func submitSIN(_ sin: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        
        return true
    }
}
