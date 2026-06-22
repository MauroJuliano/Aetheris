import SwiftUI

protocol BirthdateServicing {
    func submitBirthdate(_ birthdate: String) async throws -> Bool
}

final class MockBirthdateService: BirthdateServicing {
    var shouldFail: Bool = false
    var delay: TimeInterval = 1.5
    
    func submitBirthdate(_ birthdate: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        
        return true
    }
}
