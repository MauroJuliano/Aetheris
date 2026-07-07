import SwiftUI

enum TransferPinFactory {
    @MainActor
    static func make(
        receipt: TransferReceiptModel,
        onBack: @escaping () -> Void,
        onValidPin: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            TransferPinView(
                viewModel: TransferPinViewModel(receipt: receipt),
                onBack: onBack,
                onValidPin: onValidPin
            )
        )
    }
}
