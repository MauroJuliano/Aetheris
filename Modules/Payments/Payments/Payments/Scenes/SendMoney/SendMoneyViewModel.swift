import Combine
import Foundation

final class SendMoneyViewModel: ObservableObject {
    @Published private(set) var session: SendMoneySession?

    private let service: any SendMoneyServicing

    init(service: any SendMoneyServicing) {
        self.service = service
    }

    func load() async {
        do {
            session = try await service.loadSession()
        } catch {
            session = .mock
        }
    }

    func canContinue(currentAmount: Decimal) -> Bool {
        currentAmount > 0
    }

    func continueTapped(
        selectedBeneficiary: Beneficiary,
        currentAmount: Decimal,
        formattedAmount: String
    ) -> TransferReceiptModel? {
        guard canContinue(currentAmount: currentAmount) else { return nil }
        return makeReceiptModel(
            selectedBeneficiary: selectedBeneficiary,
            formattedAmount: formattedAmount
        )
    }

    func makeReceiptModel(
        selectedBeneficiary: Beneficiary,
        formattedAmount: String
    ) -> TransferReceiptModel {
        TransferReceiptModel(
            amount: formattedAmount,
            recipientName: selectedBeneficiary.name,
            recipientEmail: selectedBeneficiary.pixKey,
            accountName: session?.account.name ?? SendMoneySession.mock.account.name,
            accountLastDigits: session?.account.lastDigits ?? SendMoneySession.mock.account.lastDigits,
            date: formattedReceiptDate,
            referenceId: receiptReferenceId
        )
    }

    var walletBalance: Decimal {
        Decimal(session?.wallet.available ?? SendMoneySession.mock.wallet.available)
    }

    private var formattedReceiptDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        return formatter.string(from: Date())
    }

    private var receiptReferenceId: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd-HHmmss"
        return "TRX\(formatter.string(from: Date()))"
    }
}
