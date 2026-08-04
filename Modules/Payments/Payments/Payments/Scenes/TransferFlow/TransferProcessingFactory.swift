import Core
import SwiftUI

enum TransferProcessingFactory {
    @MainActor
    static func make(
        coreService: any HasCoreService,
        submission: TransferSubmission,
        onCompleted: @escaping (TransferReceiptModel) -> Void,
        onTryLater: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            TransferProcessingView(
                viewModel: TransferProcessingViewModel(
                    submission: submission,
                    service: SendMoneyService(coreService: coreService)
                ),
                onCompleted: onCompleted,
                onTryLater: onTryLater
            )
        )
    }
}
