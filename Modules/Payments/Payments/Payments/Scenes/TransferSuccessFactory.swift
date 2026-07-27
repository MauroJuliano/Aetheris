import SwiftUI

enum TransferSuccessFactory {
    @MainActor
    static func make(
        model: TransferReceiptModel,
        onBack: @escaping () -> Void = {},
        onDone: @escaping () -> Void = {},
        onNewTransfer: @escaping () -> Void = {},
        onCopyReference: @escaping (String) -> Void = { _ in }
    ) -> TransferSuccessView {
        TransferSuccessView(
            viewModel: TransferSuccessViewModel(
                model: model,
                onBack: onBack,
                onDone: onDone,
                onNewTransfer: onNewTransfer,
                onCopyReference: onCopyReference
            )
        )
    }
}
