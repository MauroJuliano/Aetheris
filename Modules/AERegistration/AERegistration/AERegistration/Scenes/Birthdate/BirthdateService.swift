import Core
import SwiftUI

protocol BirthdateServicing {
    func submitBirthdate(_ birthdate: String) async throws -> Bool
}

final class BirthdateService: BirthdateServicing {
    private let coreService: any HasCoreService
    
    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func submitBirthdate(_ birthdate: String) async throws -> Bool {
        try await coreService.execute(RegistrationEndpoint.birthdate(birthdate))
    }
}
