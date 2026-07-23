import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class SendMoneyViewModel: ObservableObject {
    let amountViewModel = TransferAmountViewModel(balance: 1000)

    func continueTapped(selectedBeneficiary: Beneficiary) -> TransferReceiptModel {
        makeReceiptModel(selectedBeneficiary: selectedBeneficiary)
    }

    func makeReceiptModel(selectedBeneficiary: Beneficiary) -> TransferReceiptModel {
        TransferReceiptModel(
            amount: amountViewModel.formattedAmount,
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
