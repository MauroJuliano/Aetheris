import SwiftUI

protocol UserNameServicing {
    func submitUserName(_ userName: String) async throws -> Bool
}

final class mockUserNameService: UserNameServicing {
    var shouldFail: Bool = false
    var delay: TimeInterval = 1.5
    
    func submitUserName(_ userName: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        
        return true
    }
}
