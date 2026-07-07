import SwiftUI

enum TransferProcessingFactory {
    @MainActor
    static func make(
        receipt: TransferReceiptModel,
        onCompleted: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            TransferProcessingView(
                viewModel: TransferProcessingViewModel(receipt: receipt),
                onCompleted: onCompleted
            )
        )
    }
}
