import Core
import Foundation
import UIKit

@MainActor
final class BeneficiaryDetailsViewModel: ObservableObject {
    @Published private(set) var beneficiary: BeneficiaryDetailsModel?
    @Published private(set) var isLoading = false
    @Published private(set) var isRemoving = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var actionErrorMessage: String?

    private let beneficiaryId: UUID
    private let service: any BeneficiaryDetailsServicing
    private var hasLoaded = false

    init(beneficiaryId: UUID, service: any BeneficiaryDetailsServicing) {
        self.beneficiaryId = beneficiaryId
        self.service = service
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await load()
    }

    func load() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            beneficiary = try await service.fetchBeneficiaryDetails(beneficiaryId: beneficiaryId)
            hasLoaded = true
        } catch {
            errorMessage = Self.message(for: error, fallback: Strings.BeneficiaryDetails.unavailableTitle)
        }
    }

    func removeBeneficiary() async -> Bool {
        guard !isRemoving else { return false }

        isRemoving = true
        actionErrorMessage = nil

        defer { isRemoving = false }

        do {
            try await service.removeBeneficiary(beneficiaryId: beneficiaryId)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            return true
        } catch {
            actionErrorMessage = Self.message(for: error, fallback: Strings.BeneficiaryDetails.actionErrorTitle)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return false
        }
    }

    func dismissActionError() {
        actionErrorMessage = nil
    }

    private static func message(for error: Error, fallback: String) -> String {
        if let coreError = error as? CoreServiceError,
           let message = coreError.serverMessage {
            return message
        }

        return fallback
    }
}
