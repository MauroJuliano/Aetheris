import Combine
import Core
import Foundation

final class SendMoneyViewModel: ObservableObject {
    @Published private(set) var session: SendMoneySession?
    @Published private(set) var isLoading = true
    @Published private(set) var errorMessage: String?

    private let service: any SendMoneyServicing
    private var isRequestInFlight = false

    init(service: any SendMoneyServicing) {
        self.service = service
    }

    func load() async {
        guard !isRequestInFlight else { return }
        isRequestInFlight = true
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
            isRequestInFlight = false
        }

        do {
            session = try await service.loadSession()
        } catch {
            session = nil
            errorMessage = Self.message(for: error)
        }
    }

    func canContinue(
        selectedBeneficiary: Beneficiary?,
        currentAmount: Decimal
    ) -> Bool {
        selectedBeneficiary != nil &&
            session != nil &&
            currentAmount > 0 &&
            currentAmount <= walletBalance
    }

    func continueTapped(
        selectedBeneficiary: Beneficiary?,
        currentAmount: Decimal,
        formattedAmount: String
    ) -> TransferDraft? {
        guard canContinue(
            selectedBeneficiary: selectedBeneficiary,
            currentAmount: currentAmount
        ) else { return nil }
        guard let session else { return nil }
        guard let selectedBeneficiary else { return nil }

        return TransferDraft(
            amount: currentAmount,
            formattedAmount: formattedAmount,
            currency: session.wallet.currency,
            beneficiaryName: selectedBeneficiary.name,
            beneficiaryIdentifier: selectedBeneficiary.pixKey,
            accountName: session.account.name,
            accountLastDigits: session.account.lastDigits
        )
    }

    var walletBalance: Decimal {
        Decimal(session?.wallet.available ?? 0)
    }

    private static func message(for error: Error) -> String {
        if let coreError = error as? CoreServiceError,
           let message = coreError.serverMessage {
            return message
        }
        return Strings.HomeApp.genericErrorDescription
    }
}
