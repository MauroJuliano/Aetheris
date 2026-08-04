import Combine
import Core
import Foundation

final class SendMoneyViewModel: ObservableObject {
    @Published private(set) var session: SendMoneySession?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: any SendMoneyServicing

    init(service: any SendMoneyServicing) {
        self.service = service
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            session = try await service.loadSession()
        } catch {
            session = nil
            errorMessage = Self.message(for: error)
        }
    }

    func canContinue(currentAmount: Decimal) -> Bool {
        session != nil && currentAmount > 0 && currentAmount <= walletBalance
    }

    func continueTapped(
        selectedBeneficiary: Beneficiary,
        currentAmount: Decimal,
        formattedAmount: String
    ) -> TransferDraft? {
        guard canContinue(currentAmount: currentAmount) else { return nil }
        guard let session else { return nil }
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
