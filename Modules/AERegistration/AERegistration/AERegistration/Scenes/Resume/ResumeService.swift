import Core
import Foundation

protocol RegistrationServicing {
    func submitProfile(_ request: RegistrationProfileRequest) async throws -> Bool
    func submitPassword(_ request: RegistrationPasswordRequest) async throws -> Bool
}

final class RegistrationService: RegistrationServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func submitProfile(_ request: RegistrationProfileRequest) async throws -> Bool {
        try await coreService.execute(RegistrationEndpoint.profile(request))
    }

    func submitPassword(_ request: RegistrationPasswordRequest) async throws -> Bool {
        try await coreService.execute(RegistrationEndpoint.password(request))
    }
}
