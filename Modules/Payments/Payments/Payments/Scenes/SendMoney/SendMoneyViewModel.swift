import AetherisDesignSystem
import Foundation

final class SendMoneyViewModel: ObservableObject {
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
            accountName: "Main Account",
            accountLastDigits: "1234",
            date: formattedReceiptDate,
            referenceId: receiptReferenceId
        )
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
