import Core
import AetherisDesignSystem
import SwiftUI

struct ViewReportView: View {
    @StateObject private var viewModel: ViewReportViewModel
    let onLoadingFinished: () -> Void

    init(
        viewModel: ViewReportViewModel,
        onLoadingFinished: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onLoadingFinished = onLoadingFinished
    }

    var body: some View {
        ViewReportSkeleton()
            .task {
                viewModel.load(onLoadingFinished: onLoadingFinished)
            }
    }
}

