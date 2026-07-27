import Core
import SwiftUI

protocol MothersNameInputServicing {
    func submitMothersName(_ mothersName: String) async throws -> RegisterModel
}

final class MothersNameInputService: MothersNameInputServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }
    
    func submitMothersName(_ mothersName: String) async throws -> RegisterModel {
        try await coreService.execute(RegistrationEndpoint.mothersName(mothersName))
    }
}
