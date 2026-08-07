import SwiftUI
import Core

enum SendMoneyFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        selectedBeneficiary: Binding<Beneficiary?>,
        onBackAction: (() -> Void)? = nil,
        onChangeBeneficiary: @escaping () -> Void = {},
        onContinue: @escaping (TransferDraft) -> Void = { _ in }
    ) -> SendMoney {
        SendMoney(
            viewModel: SendMoneyViewModel(service: SendMoneyService(coreService: coreService)),
            selectedBeneficiary: selectedBeneficiary,
            onBackAction: onBackAction,
            onChangeBeneficiary: onChangeBeneficiary,
            onContinue: onContinue
        )
    }
}
