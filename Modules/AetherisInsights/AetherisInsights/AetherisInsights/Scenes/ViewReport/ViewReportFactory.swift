import SwiftUI

enum ViewReportFactory {
    @MainActor
    static func make(
        viewModel: ViewReportViewModel,
        onLoadingFinished: @escaping () -> Void
    ) -> ViewReportView {
        ViewReportView(
            viewModel: viewModel,
            onLoadingFinished: onLoadingFinished
        )
    }
}
