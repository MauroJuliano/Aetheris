import SwiftUI
import Core

@MainActor
final class ResumeViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published var submissionError: CoreServiceError?

    private let draft: RegistrationDraft
    private let service: any RegistrationServicing

    init(service: any RegistrationServicing, draft: RegistrationDraft) {
        self.service = service
        self.draft = draft
    }

    var resumeList: [ResumeListModel] {
        [
            .init(image: "lock.fill", description: Strings.Sin.title, value: draft.sin, kind: .sin),
            .init(image: "heart.fill", description: Strings.MothersName.title, value: draft.mothersName, kind: .mothersName),
            .init(image: "person.fill", description: Strings.UserName.title, value: draft.userName, kind: .userName),
            .init(image: "envelope.fill", description: Strings.Email.title, value: draft.email, kind: .email),
            .init(image: "calendar", description: Strings.Birthdate.title, value: draft.birthdate, kind: .birthdate)
        ]
    }

    @discardableResult
    func submit() async -> Bool {
        guard !isLoading else { return false }

        isLoading = true
        submissionError = nil
        defer { isLoading = false }

        do {
            let request = RegistrationProfileRequest(
                sin: draft.sin.filter(\.isNumber),
                mothersName: draft.mothersName,
                userName: draft.userName,
                email: draft.email,
                birthdate: draft.birthdate
            )
            let succeeded = try await service.submitProfile(request)
            if !succeeded {
                submissionError = .invalidResponse
            }
            return succeeded
        } catch {
            submissionError = (error as? CoreServiceError) ?? .invalidResponse
            return false
        }
    }

    var submissionErrorDescription: String {
        submissionError?.serverMessage ?? Strings.SubmissionError.description
    }

    func dismissSubmissionError() {
        submissionError = nil
    }
}
