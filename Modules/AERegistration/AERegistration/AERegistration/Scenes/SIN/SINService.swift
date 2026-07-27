import Core
import SwiftUI

protocol SINServiceProtocol {
    func submitSIN(_ sin: String) async throws -> Bool
}

final class SINService: SINServiceProtocol {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }
    
    func submitSIN(_ sin: String) async throws -> Bool {
        try await coreService.execute(RegistrationEndpoint.sin(sin))
    }
}
