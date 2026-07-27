import Core
import SwiftUI

protocol UserNameServicing {
    func submitUserName(_ userName: String) async throws -> Bool
}

final class UserNameService: UserNameServicing {
    private let coreService: any HasCoreService
    
    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func submitUserName(_ userName: String) async throws -> Bool {
        try await coreService.execute(RegistrationEndpoint.userName(userName))
    }
}
