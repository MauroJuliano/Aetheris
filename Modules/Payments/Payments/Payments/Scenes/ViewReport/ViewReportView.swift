import AetherisDesignSystem
import SwiftUI

struct ViewReportView: View {
    let onLoadingFinished: () -> Void

    @State private var didTriggerCompletion = false

    var body: some View {
        ViewReportSkeleton()
        .onAppear {
            scheduleFailure()
        }
    }

    private func scheduleFailure() {
        guard !didTriggerCompletion else { return }
        didTriggerCompletion = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            onLoadingFinished()
        }
    }
}

#Preview {
    ViewReportView(onLoadingFinished: {})
}
