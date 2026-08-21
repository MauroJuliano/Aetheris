import Core
import Foundation
import UIKit

@MainActor
final class RequestMoneyViewModel: ObservableObject {
    static let reasonLimit = 60

    @Published private(set) var requesterName = ""
    @Published private(set) var recentContacts: [RequestContactModel] = []
    @Published private(set) var amountPresets: [RequestMoneyAmountPresetModel] = []
    @Published private(set) var selectedContact: RequestContactModel?

    @Published var selectedMode: RequestMoneyMode = .contact
    @Published var amountText = "" {
        didSet {
            let formatted = CurrencyInputFormatter.format(amountText)
            if amountText != formatted { amountText = formatted }
        }
    }
    @Published var reason = "" {
        didSet {
            if reason.count > Self.reasonLimit { reason = String(reason.prefix(Self.reasonLimit)) }
        }
    }

    @Published private(set) var isLoading = false
    @Published private(set) var isSubmitting = false

    @Published private(set) var loadingErrorMessage: String?
    @Published private(set) var submitErrorMessage: String?

    private var hasLoaded = false
    private let service: any RequestMoneyServicing

    init(
        service: any RequestMoneyServicing,
        initialContact: RequestContactModel? = nil
    ) {
        self.service = service
        selectedContact = initialContact
    }

    var amount: Decimal {
        CurrencyInputFormatter.decimal(from: amountText)
    }

    var normalizedReason: String? {
        let value = reason.trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }

    var canSubmit: Bool {
        guard !isSubmitting, amount > 0 else {
            return false
        }

        switch selectedMode {
        case .contact:
            return selectedContact != nil
        case .shareLink:
            return true
        }
    }

    var primaryButtonTitle: String {
        switch selectedMode {
        case .contact:
            return Strings.RequestMoney.sendRequest
        case .shareLink:
            return Strings.RequestMoney.shareRequest
        }
    }

    func loadIfNeeded() async {
        guard !hasLoaded else {
            return
        }

        await load()
    }

    func load() async {
        guard !isLoading else {
            return
        }

        isLoading = true
        loadingErrorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let dashboard = try await service.loadDashboard()
            requesterName = dashboard.requesterName
            recentContacts = Self.merging(
                selectedContact: selectedContact,
                into: dashboard.recentContacts
            )
            amountPresets = dashboard.amountPresets

            if reason.isEmpty,
               let defaultReason = dashboard.defaultReason {
                reason = defaultReason
            }

            hasLoaded = true
        } catch {
            loadingErrorMessage = Self.message(for: error)
        }
    }

    func selectMode(_ mode: RequestMoneyMode) {
        selectedMode = mode

        if mode == .shareLink {
            selectedContact = nil
        }
    }

    func selectContact(_ contact: RequestContactModel) {
        selectedContact = contact
    }

    func selectPreset(_ value: Decimal) {
        amountText = CurrencyInputFormatter.format(value)
    }

    func submit() async -> RequestMoneySubmissionResult? {
        guard canSubmit else {
            return nil
        }

        isSubmitting = true
        submitErrorMessage = nil

        defer {
            isSubmitting = false
        }

        do {
            let request: MoneyRequestModel
            let shouldShareLink: Bool

            switch selectedMode {
            case .contact:
                guard let selectedContact else {
                    return nil
                }

                request = try await service.createRequest(
                    contactId: selectedContact.id,
                    amount: amount,
                    reason: normalizedReason
                )
                shouldShareLink = false
            case .shareLink:
                request = try await service.createSharedRequest(
                    amount: amount,
                    reason: normalizedReason
                )
                shouldShareLink = true
            }

            UINotificationFeedbackGenerator()
                .notificationOccurred(.success)

            return RequestMoneySubmissionResult(
                request: request,
                shouldShareLink: shouldShareLink
            )
        } catch {
            submitErrorMessage = Self.message(for: error)

            UINotificationFeedbackGenerator()
                .notificationOccurred(.error)

            return nil
        }
    }

    func dismissSubmitError() {
        submitErrorMessage = nil
    }

    private static func message(for error: Error) -> String {
        if let coreError = error as? CoreServiceError,
           let message = coreError.serverMessage {
            return message
        }

        return Strings.HomeApp.genericErrorDescription
    }

    private static func merging(
        selectedContact: RequestContactModel?,
        into contacts: [RequestContactModel]
    ) -> [RequestContactModel] {
        guard let selectedContact,
              !contacts.contains(where: { $0.id == selectedContact.id }) else {
            return contacts
        }

        return [selectedContact] + contacts
    }
}

struct RequestMoneySubmissionResult {
    let request: MoneyRequestModel
    let shouldShareLink: Bool
}
