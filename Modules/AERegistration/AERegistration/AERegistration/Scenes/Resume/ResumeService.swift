import Core
import Foundation

protocol ResumeServicing {
    func completeRegistration(_ request: RegistrationCompletionRequest) async throws -> Bool
}

final class ResumeService: ResumeServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func completeRegistration(_ request: RegistrationCompletionRequest) async throws -> Bool {
        try await coreService.execute(RegistrationEndpoint.complete(request))
    }
}
