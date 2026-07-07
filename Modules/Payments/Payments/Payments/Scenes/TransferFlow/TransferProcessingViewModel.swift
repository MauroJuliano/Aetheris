import Foundation
import SwiftUI

@MainActor
final class TransferProcessingViewModel: ObservableObject {
    @Published private(set) var isAnimating = false

    let receipt: TransferReceiptModel

    init(receipt: TransferReceiptModel) {
        self.receipt = receipt
    }

    func start(onCompleted: @escaping () -> Void) {
        guard !isAnimating else { return }
        isAnimating = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            onCompleted()
        }
    }
}
