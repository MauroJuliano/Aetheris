import Foundation

@MainActor
final class TransferSuccessViewModel: ObservableObject {
    let model: TransferReceiptModel
    let onBack: () -> Void
    let onDone: () -> Void
    let onNewTransfer: () -> Void
    let onCopyReference: (String) -> Void

    init(
        model: TransferReceiptModel,
        onBack: @escaping () -> Void,
        onDone: @escaping () -> Void,
        onNewTransfer: @escaping () -> Void,
        onCopyReference: @escaping (String) -> Void
    ) {
        self.model = model
        self.onBack = onBack
        self.onDone = onDone
        self.onNewTransfer = onNewTransfer
        self.onCopyReference = onCopyReference
    }
}
