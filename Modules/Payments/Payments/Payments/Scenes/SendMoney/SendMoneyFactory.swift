import SwiftUI

enum SendMoneyFactory {
    @MainActor
    static func make(
        selectedBeneficiary: Binding<Beneficiary>,
        onBackAction: (() -> Void)? = nil,
        onChangeBeneficiary: @escaping () -> Void = {},
        onContinue: @escaping (TransferReceiptModel) -> Void = { _ in }
    ) -> SendMoney {
        SendMoney(
            selectedBeneficiary: selectedBeneficiary,
            onBackAction: onBackAction,
            onChangeBeneficiary: onChangeBeneficiary,
            onContinue: onContinue
        )
    }
}
