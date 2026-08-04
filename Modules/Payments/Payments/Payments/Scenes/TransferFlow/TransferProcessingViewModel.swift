import Core
import Foundation

@MainActor
final class TransferProcessingViewModel: ObservableObject {
    enum State: Equatable {
        case submitting
        case failed(String)
    }

    @Published private(set) var state: State = .submitting

    let submission: TransferSubmission
    private let service: any SendMoneyServicing
    private var isSubmitting = false

    init(submission: TransferSubmission, service: any SendMoneyServicing) {
        self.submission = submission
        self.service = service
    }

    func submit(onCompleted: @escaping (TransferReceiptModel) -> Void) async {
        guard !isSubmitting else { return }
        isSubmitting = true
        state = .submitting
        defer { isSubmitting = false }

        do {
            let response = try await service.submit(submission)
            onCompleted(TransferReceiptModel(response: response))
        } catch {
            state = .failed(Self.message(for: error))
        }
    }

    private static func message(for error: Error) -> String {
        if let coreError = error as? CoreServiceError,
           let message = coreError.serverMessage {
            return message
        }
        return Strings.TransferProcessing.errorDescription
    }
}
