import AetherisTransfersInterface
import Core
import Foundation

enum BeneficiaryDetailsFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        beneficiaryId: UUID,
        onBackAction: @escaping () -> Void,
        onNotificationsTap: @escaping () -> Void = {},
        onTransferTap: @escaping (Beneficiary) -> Void = { _ in },
        onRequestMoneyTap: @escaping (RequestContactModel) -> Void = { _ in },
        onMoreOptionsTap: @escaping (UUID) -> Void = { _ in },
        onTransactionTap: @escaping (UUID) -> Void = { _ in },
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onBeneficiaryRemoved: @escaping () -> Void = {}
    ) -> BeneficiaryDetailsScreen {
        BeneficiaryDetailsScreen(
            viewModel: BeneficiaryDetailsViewModel(
                beneficiaryId: beneficiaryId,
                service: BeneficiaryDetailsService(coreService: coreService)
            ),
            onBackAction: onBackAction,
            onNotificationsTap: onNotificationsTap,
            onTransferTap: onTransferTap,
            onRequestMoneyTap: onRequestMoneyTap,
            onMoreOptionsTap: onMoreOptionsTap,
            onTransactionTap: onTransactionTap,
            onTransactionHistoryTap: onTransactionHistoryTap,
            onBeneficiaryRemoved: onBeneficiaryRemoved
        )
    }
}
