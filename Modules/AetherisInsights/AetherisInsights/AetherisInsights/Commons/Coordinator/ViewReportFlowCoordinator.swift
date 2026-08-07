import AetherisDesignSystem
import Core
import SwiftUI

struct ViewReportFlowCoordinator: View {
    let coreService: any HasCoreService
    let onBack: () -> Void
    @State private var showsError = false

    var body: some View {
        ZStack {
            ViewReportFactory.make(
                viewModel: ViewReportViewModel(
                    service: ViewReportService(coreService: coreService)
                ),
                onLoadingFinished: {
                    showsError = true
                }
            )

            if showsError {
                FeedbackView(
                    title: Strings.HomeApp.genericErrorTitle,
                    description: Strings.HomeApp.genericErrorDescription,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    secondaryButtonTitle: Strings.HomeApp.tryLater,
                    onPrimaryAction: {
                        showsError = false
                    },
                    onSecondaryAction: {
                        onBack()
                    }
                )
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ViewReportFlowCoordinator(
        coreService: DemoCoreService(delay: 0),
        onBack: {}
    )
}
